module FeatureBox
  class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :suggestion
    attr_accessible :text
  
  
    validates :text,  :presence => true, :length => {
     :maximum => Settings.max_comment_chars 
    }
    validates :user,  :presence => true
    validates :suggestion, :presence => true
  end

end
