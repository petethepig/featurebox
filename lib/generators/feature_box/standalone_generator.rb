require 'generators/feature_box/generator_base'
module FeatureBox
  module Generators
    class StandaloneGenerator < Rails::Generators::Base
      include GeneratorBase
      desc "Installs FeatureBox to a new application"
      def feature_box_install
        
        #migrate
        copy_migrations [/00_.*/,/01_.*/,/02_.*/,/03_.*/,/04_.*/,/05_.*/]
        rake  "db:migrate"
        
        #route
        route "mount FeatureBox::Engine => '/'"
        template "initializers/initializer.rb", "config/initializers/feature_box.rb"
        
        #devise configuration
        generate "devise:install"
        append_file('config/initializers/devise.rb', open(File.expand_path("./../templates/initializers/new_devise_initializer.rb", __FILE__)).read)
        
        #seed with admin credentials
        rake  "feature_box:seed"

      end
    end
  end
end
