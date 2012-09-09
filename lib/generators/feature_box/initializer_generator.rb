require 'generators/feature_box/generator_base'
module FeatureBox
  module Generators    
    class InitializerGenerator < Rails::Generators::Base
      include GeneratorBase
      desc "Generate Feature Box initializer"
      def copy_initializer
        @has_devise = false

        template "initializers/initializer.rb", "config/initializers/feature_box.rb"
      end
    end
  end
end
