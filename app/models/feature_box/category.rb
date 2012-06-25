module FeatureBox
  class Category < ActiveRecord::Base
    attr_accessible :name
    has_many :suggestions, :dependent => :destroy

    validates :name,  :presence => true, :length => { 
      :maximum => Settings.max_category_name_chars 
    }

    @@default=Category.new :name=>"All Suggestions"
    def self.default
      @@default
    end
  end
end
