class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.references :user, foreign_key: true
      t.string :image_url
      t.text :caption
      t.integer :vote_count
      t.boolean :is_owner

      t.timestamps
    end
  end
end
