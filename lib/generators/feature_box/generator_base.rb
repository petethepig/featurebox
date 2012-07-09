require 'find'
module FeatureBox
  module Generators
    # Helper methods
    module GeneratorBase
      
      include Rails::Generators::Migration
      
      module ClassMethods
        def next_migration_number(path)
          unless @prev_migration_nr
            @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
          else
            @prev_migration_nr += 1
          end
          @prev_migration_nr.to_s
        end
      end

      def self.included clazz 
        clazz.source_root File.expand_path("../templates", __FILE__)
        clazz.extend include Rails::Generators::Migration::ClassMethods
        clazz.extend ClassMethods
      end

      def copy_migrations patterns
        model_name = @model_name || "User"
        Find.find(File.expand_path("../templates/migrations", __FILE__)) do |path|
          patterns.each do |pattern|
            if pattern.match(path)
              migration_template path, 'db/migrate/'+(File.basename(path,".rb"))[3..-1].gsub(/{model_name}/,model_name.tableize.gsub(/\//,''))
            end
          end
        end
      end

      def trim str
        (str.gsub /^[\s]*([^\s])/m, '\1')
      end

      def trim_f str
        (str.gsub /^[\s]*\|/m, '')
      end

    end
  end
end
