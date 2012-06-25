class CreateFeatureBoxSuggestions < ActiveRecord::Migration
  def change
    create_table :feature_box_suggestions do |t|
      t.string :title, :null => false
      t.text :description, :null => false      
      t.string :status, :default => "default"
      t.references :user
      t.references :category

      t.timestamps
    end
    add_index :feature_box_suggestions, :user_id
    add_index :feature_box_suggestions, :category_id
  end
end
