class CreateFeatureBoxComments < ActiveRecord::Migration
  def change
    create_table :feature_box_comments do |t|
      t.references :user
      t.references :suggestion
      t.text :text, :null => false

      t.timestamps
    end
    add_index :feature_box_comments, :user_id
    add_index :feature_box_comments, :suggestion_id
  end
end
