class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :mode
      t.references :challenger
      t.references :opponent
      t.date :expiration
      t.references :recipe, foreign_key: true
      t.date :voting_end
      t.boolean :accepted

      t.timestamps
    end
  end
end
