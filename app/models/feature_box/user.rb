module FeatureBox
  class User < Settings.devise_parent_model.safe_constantize

    devise :database_authenticatable, :registerable, :recoverable, 
           :rememberable, :trackable, :validatable

    has_many :suggestions, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    has_many :votes, :dependent => :destroy

    attr_accessible :name, :email, :password, :password_confirmation, :remember_me

    def can_vote? suggestion
      if !Settings.can_vote_own_suggestions || votes_left > 0
        return false
      end
      if votes_left < 0 then 
        return false
      end
      if Settings.per_suggestion_limit < 0
        return true 
      else 
        return Vote.where(:user_id => id, :suggestion_id=>suggestion.id).size < Settings.per_suggestion_limit
      end
    end

    def votes_left 
      if Settings.total_limit < 0 then 
        return 100
      end 
      condition = Settings.time_limit.ago
      used = Vote.where("user_id = ? AND created_at > ?", self.id, condition).size
      return Settings.total_limit - used
    end

    def can_vote_date 
      condition = Settings.time_limit.ago
      last_vote = Vote.where("user_id = ? AND created_at > ?", self.id, condition).order("created_at ASC").limit(1).first
      return last_vote.created_at.in(Settings.time_limit)
    end

    def method_missing(method, *args, &block)
      if method == :name
        self.errors[:base] << ("You need to define 'name' and other methods in your User model") 
        "You need to define 'name' and other methods in your User model"
      elsif method == :name=
        self.errors[:base] << ("You need to define 'name=' and other methods in your User model") 
        false
      elsif method == :admin?
        self.errors[:base] << ("You need to define 'admin?' and other methods in your User model") 
        false       
      elsif method == :admin=
        self.errors[:base] << ("You need to define 'admin=' and other methods in your User model") 
        false
      else
        super
      end
    end

  end
end