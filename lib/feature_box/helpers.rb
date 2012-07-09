module FeatureBox
  module Helpers

    def self.define_helpers
      
      #We don't need these helpers if application is in standalone mode
      return if FeatureBox::Settings.devise_router_name == :feature_box

      model_name = FeatureBox::Settings.devise_parent_model.underscore
      devise_router_name = FeatureBox::Settings.devise_router_name.to_s
      #url helpers
      mappings = Devise.mappings.values.map(&:used_helpers).flatten.uniq
      routes = Devise::URL_HELPERS.slice(*mappings)
      routes.each do |module_name, actions|
        [:path, :url].each do |path_or_url|
          actions.each do |action|
            action = action ? "#{action}_" : ""
            helper = "#{action}user_#{module_name}_#{path_or_url}"
            real_helper = "#{action}#{model_name}_#{module_name}_#{path_or_url}"

            class_eval <<-URL_HELPERS, __FILE__, __LINE__ + 1
              def #{helper}
                #{devise_router_name}.#{real_helper}
              end
            URL_HELPERS
          end
        end
      end

      #We don't need these helpers if user model's name is "User"
      return if model_name == 'user'
      
      helpers=[:current_user, :user_session, :user_signed_in?, :authenticate_user!]
      helpers.each do |helper|
        helper = helper.to_s
        real_helper = helper.gsub(/user/,model_name)
        class_eval <<-URL_HELPERS
          def #{helper}    #{if helper == 'authenticate_user!' then '(opts={})' end}
            #{real_helper} #{if helper == 'authenticate_user!' then 'opts'      end}
          end
        URL_HELPERS
      end

    end
    def self.included m
      self.define_helpers
    end
  end
end