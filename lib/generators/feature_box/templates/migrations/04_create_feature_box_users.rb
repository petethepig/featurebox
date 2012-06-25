class CreateFeatureBoxUsers < ActiveRecord::Migration
  def change
    create_table :feature_box_users do |t|
      t.string :name, :null => false
      t.boolean :admin, :default => false
      
      t.timestamps
    end
  end
end
