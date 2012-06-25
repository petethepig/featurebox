require 'generators/feature_box/generator_base'
module FeatureBox
  module Generators    
    class ExistingGenerator < Rails::Generators::Base
      include GeneratorBase
      desc "Installs FeatureBox to existing application"
      def feature_box_install
        #name of the User model
        @users_table_name = file_name || "User"

        #variable for templates
        @has_devise = true

        #migrate
        copy_migrations [/00_.*/,/01_.*/,/02_.*/,/03_.*/,/06_.*/]
        rake  "db:migrate"

        #route
        route "mount FeatureBox::Engine => '/feature_box'"
        
        #initializer
        template "initializers/initializer.rb", "config/initializers/feature_box.rb"
      end
    end
  end
end
