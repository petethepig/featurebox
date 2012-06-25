require "feature_box/devise/redirects"
class FeatureBox::Devise::SessionsController < Devise::SessionsController
  include FeatureBox::Devise::Redirects
end
