module FeatureBox
  class Suggestion < ActiveRecord::Base
    attr_accessible :title, :description, :status
    
    belongs_to :user, :class_name=>"FeatureBox::User"
    belongs_to :category

    has_many :votes, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    
    validates :title,  :presence => true, :length => { 
      :maximum => Settings.max_suggestion_header_chars 
    }
    validates :description, :presence => true, :length => { 
      :maximum => Settings.max_suggestion_description_chars 
    }
    validates :user,  :presence => true
    validates :category, :presence => true
    validates_inclusion_of :status, :in => [:default, :in_progress, :complete]

    after_save :add_first_vote


    def status
      read_attribute(:status).to_sym
    end

    def status= (value)
      write_attribute(:status, value.to_s)
    end

    def user_votes(user)
      Vote.where(:suggestion_id=>id,:user_id=>user.id).size()
    end

    def vote(user)
      if  user.votes_left > 0 && user.can_vote?(self)
        v=Vote.new
        v.user=user
        v.suggestion=self
        v.save
      end
    end

    def self.find_those_with hash
      category    = hash[:category]
      order_type  = hash[:order_type]
      limit       = hash[:limit]
      offset      = hash[:offset]

      category_filter = if category.id then Suggestion.where(:category_id => category.id) else Suggestion end
        
      case order_type
        when :most_popular
          where_part = "WHERE status <> 'complete' "
          if category.id!=nil then 
            where_part += "AND #{self.table_name}.category_id = #{category.id.to_s}"
          end
          suggestions = Suggestion.find_by_sql(
            "SELECT COUNT(*) AS count_all, #{self.table_name}.*
             FROM #{self.table_name} 
             INNER JOIN #{Vote.table_name} 
             ON #{Vote.table_name}.suggestion_id = #{self.table_name}.id 
             #{where_part}
             GROUP BY #{self.table_name}.id
             ORDER BY count_All DESC 
             LIMIT #{limit.to_s} OFFSET #{offset.to_s}")
          total = category_filter.where("status <> ?", :complete).size
        when :in_progress, :complete
          suggestions = category_filter.where(:status => order_type).order("created_at DESC").limit(limit).offset(offset)
          total = category_filter.where(:status => order_type).size
        when :newest
          suggestions = category_filter.where("status <> ?", :complete).order("created_at DESC").limit(limit).offset(offset)
          total = category_filter.where("status <> ?", :complete).size
        else
          raise ArgumentError.new("Unknown order_type")
      end
      return suggestions, total
    end
    
    def self.find_my type_of_impact, hash

      user    = hash[:user]
      limit   = hash[:limit]
      offset  = hash[:offset]

      case type_of_impact
        when :suggestions
          suggestions = user.suggestions.order("created_at DESC").limit(limit).offset(offset)
          total = user.suggestions.size
        when :votes, :comments
          impact_table_name = eval("FeatureBox::"+type_of_impact.to_s.capitalize.chomp("s")).table_name
          suggestions = Suggestion.joins(type_of_impact).where("#{impact_table_name}.user_id = ?",user.id).order("created_at DESC").uniq.limit(limit).offset(offset)
          total = Suggestion.count_by_sql(["SELECT COUNT(DISTINCT #{self.table_name}.id) FROM #{self.table_name} INNER JOIN #{impact_table_name} ON #{impact_table_name}.suggestion_id = #{self.table_name}.id WHERE #{self.table_name}.user_id = ?", user.id])
        else 
          raise ArgumentError.new("Unknown type of impact")
      end
      return suggestions, total
    end
    
    
    private
      def add_first_vote
        if(self.votes.size == 0)
          v = Vote.new 
          v.suggestion = self
          v.user = self.user
          v.save
        end
      end
    
    
  end
end
