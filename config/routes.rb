FeatureBox::Engine.routes.draw do

  root :to => "home#index"

  match "/suggestions/(:category/(:order(/page/:page)))" => "suggestions#index", :as => :suggestions_listing
  match "/suggestions/:id/page/:page" => "suggestions#show"

  match "/my_suggestions" => "suggestions#my_suggestions", :as => :my_suggestions  
  match "/my_votes" => "suggestions#my_votes", :as => :my_votes
  match "/my_comments" => "suggestions#my_comments", :as => :my_comments

  resources :suggestions, :except => :index, :path=>'/suggestion' do
    get 'vote', :on => :member
    get 'search', :on => :collection, :as => :search  
    resources :comments, :only => [:create, :edit, :update, :destroy]
  end

  scope "/admin" do
    resources :categories, :except => :show
    resources :users, :only => [:index, :edit, :update, :destroy]
  end
  
  if FeatureBox::Settings.devise_router_name == :feature_box
    devise_for :users, { 
      class_name: 'FeatureBox::User',
      module: 'FeatureBox::Devise',
      constollers: {
        :sessions => 'feature_box/devise/sessions',
        :registrations => 'feature_box/devise/registrations',
        :passwords => 'feature_box/devise/passwords'
      }
    }
  end

end
