require 'find'
module FeatureBox
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../", __FILE__)

      desc "Copying FeatureBox views to your application folder"
      def copy_views
        directory 'app/views/feature_box', 'app/views/feature_box'
        directory 'app/views/layouts/feature_box', 'app/views/layouts/feature_box'
      end
    end
  end
end
