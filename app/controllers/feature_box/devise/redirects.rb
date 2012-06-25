module FeatureBox
  module Devise
    module Redirects
      def after_sign_in_path_for resource_or_scope
        feature_box.root_path
      end
      def after_sign_out_path_for resource_or_scope
        feature_box.root_path
      end
      def after_sign_up_path_for resource_or_scope
        feature_box.root_path
      end
      def signed_in_root_path resource_or_scope
        feature_box.root_path
      end
      def self.included m
        m.skip_authorization_check
      end
    end
  end
end