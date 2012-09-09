require 'generators/feature_box/generator_base'
module FeatureBox
  module Generators    
    class MigrationsGenerator < Rails::Generators::Base
      include GeneratorBase
      desc "Installs migrations"
      def copy_migrations_task
        
        @model_name = ask("What is the User model name? [User]")
        @model_name = "User" if @model_name.empty?
        
        migrations = eval ask("Enter migration number or range. '05' or '00..04':");
        if migrations.class == Fixnum
          copy_migration migrations
        elsif migrations.class == Range
          migrations.each do |m|
            copy_migration m
          end
        else 
          return say "Wrong format"
        end      
      end
    end
  end
end
