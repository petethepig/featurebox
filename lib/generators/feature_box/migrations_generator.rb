require 'generators/feature_box/generator_base'
module FeatureBox
  module Generators    
    class MigrationsGenerator < Rails::Generators::Base
      include GeneratorBase
      desc "Installs migrations"
      def copy_migrations_task
        
        @users_table_name = ask("What is the User model name? [User]") || "User"
        
        migrations = eval ask("Enter migration number or range. '05' or '00..04':");
        if migrations.class == Fixnum
          copy_migration migrations
        elsif migrations.class == Range
          migrations.each do |m|
            copy_migration m
          end
        elsif migrations.class == String && migrations == 'q'
          return say "Done"
        else 
          return say "Wrong format"
        end      
      end

      private 
      def copy_migration n
        n = n.to_s
        n = "0"+n if n.length < 2
        copy_migrations [Regexp.new("#{n}_.*")]
      end
    end
  end
end
