class CreateFeatureBoxCategories < ActiveRecord::Migration
  def change
    create_table :feature_box_categories do |t|
      t.string :name, :null => false
      
      t.timestamps
    end
  end
end
