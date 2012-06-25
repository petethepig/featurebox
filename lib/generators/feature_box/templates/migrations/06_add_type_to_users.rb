class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type, :string, :default=>'FeatureBox::User'
  end
end
