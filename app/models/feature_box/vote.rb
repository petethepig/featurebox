module FeatureBox
  class Vote < ActiveRecord::Base
    belongs_to :user
    belongs_to :suggestion
  end
end