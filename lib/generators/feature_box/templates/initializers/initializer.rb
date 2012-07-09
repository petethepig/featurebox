FeatureBox::Settings.setup do |settings|

  # Voting limits
  settings.per_suggestion_limit = 2
  settings.total_limit = 8
  settings.time_limit = 1.month
  settings.can_vote_own_suggestions = false

  # Listing limits
  settings.max_suggestions_on_page = 5 
  settings.max_comments_on_page = 10 

  # Admin pages listing limits
  settings.max_users_on_page = 15 
  settings.max_categories_on_page = 15 


  # Chars limits
  settings.max_suggestion_header_chars = 200   
  settings.max_suggestion_description_chars = 1000  
  settings.max_comment_chars = 1000  
  settings.max_category_name_chars = 50
  
    
  # Uncomment this line if you want to use custom mailer
  # settings.mailer = "Devise::Mailer"


  <%= if @has_devise then 'settings.devise_parent_model = "'+@model_name+'"' end %>
  <%= if @has_devise then 'settings.devise_router_name = :main_app' end %>

end
