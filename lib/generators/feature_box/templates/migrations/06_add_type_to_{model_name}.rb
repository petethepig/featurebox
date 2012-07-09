class AddTypeTo<%= @model_name.pluralize.gsub(/::/,'') %> < ActiveRecord::Migration
  def change
    add_column :<%= @model_name.pluralize.tableize.gsub(/\//,'') %>, :type, :string, :default=>'FeatureBox::User'
  end
end
