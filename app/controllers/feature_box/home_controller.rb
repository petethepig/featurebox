module FeatureBox
  class HomeController < FeatureBox::ApplicationController
  	skip_authorization_check
    def index
  	  redirect_to suggestions_listing_path(:category => Category.default.name, :order => :newest), :flash => flash
    end
  end
end