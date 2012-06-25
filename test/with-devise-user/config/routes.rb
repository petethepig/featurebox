WithDeviseUser::Application.routes.draw do
  mount FeatureBox::Engine => '/feature_box'

  devise_for :users
  
  root :to => 'home#index'
end
