require "feature_box/devise/redirects"
class FeatureBox::Devise::PasswordsController < Devise::PasswordsController
  include FeatureBox::Devise::Redirects
end
