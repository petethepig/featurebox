class CreateFeatureBoxVotes < ActiveRecord::Migration
  def change
    create_table :feature_box_votes do |t|
      t.references :user
      t.references :suggestion

      t.timestamps
    end
    add_index :feature_box_votes, :user_id
    add_index :feature_box_votes, :suggestion_id
  end
end
