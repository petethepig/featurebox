require 'feature_box/engine'
require 'feature_box/helpers'
require 'devise'
require 'cancan'
require 'cancan/ability'
require 'active_support/core_ext/object'
require 'haml'



module FeatureBox
  module Settings

    # Voting limits
    mattr_accessor :per_suggestion_limit
    @@per_suggestion_limit = 2
  
    mattr_accessor :total_limit
    @@total_limit = 8
  
    mattr_accessor :time_limit
    @@time_limit = 1.month

    mattr_accessor :can_vote_own_suggestions
    @@can_vote_own_suggestions = false
  
        
  
    # Listing limits
    mattr_accessor :max_suggestions_on_page
    @@max_suggestions_on_page = 5 
  
    mattr_accessor :max_comments_on_page
    @@max_comments_on_page = 10 
  
    # Admin pages listing limits
    mattr_accessor :max_users_on_page
    @@max_users_on_page = 15 
    
    mattr_accessor :max_categories_on_page
    @@max_categories_on_page = 15 
  
  
  
    # Chars limits
    mattr_accessor :max_suggestion_header_chars
    @@max_suggestion_header_chars = 200 
    
    mattr_accessor :max_suggestion_description_chars
    @@max_suggestion_description_chars = 1000
    
    mattr_accessor :max_comment_chars
    @@max_comment_chars = 1000
    
    mattr_accessor :max_category_name_chars
    @@max_category_name_chars = 50
    

    mattr_accessor :devise_parent_model
    @@devise_parent_model = "ActiveRecord::Base"

    mattr_accessor :devise_router_name
    @@devise_router_name = :feature_box

    mattr_accessor :mailer
    @@mailer = "Devise::Mailer"

    def self.setup
      yield self
    end
  end
end