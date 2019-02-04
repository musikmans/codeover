class CreateLeaderboards < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboards do |t|
      t.integer :scores
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
