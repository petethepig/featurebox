require "feature_box/devise/redirects"
class FeatureBox::Devise::RegistrationsController < Devise::RegistrationsController
  include FeatureBox::Devise::Redirects
end
