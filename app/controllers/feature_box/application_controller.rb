module FeatureBox

  class ApplicationController < ActionController::Base
    
    protect_from_forgery
    before_filter :retrieve_vars
    #check_authorization
    
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_path, :alert => exception.message
    end

    def current_ability
      FeatureBox::Ability.new(current_user)
    end

    def pages_helper(&code)
      @current_page = (params[:page]==nil)?0:(params[:page].to_i)
      @current_page = @current_page<1?1:@current_page
      limit = Settings.max_suggestions_on_page
      offset=@current_page*limit-limit
      offset=offset<0?0:offset

      code.call limit, offset

      @last_page = (@total / limit.to_f).ceil
    end

    def retrieve_vars
      @categories = Array [Category.default] + Category.all    
    end

    include FeatureBox::Helpers

  end
end

