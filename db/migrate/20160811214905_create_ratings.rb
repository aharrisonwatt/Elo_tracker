class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :game_id, null: false
      t.integer :elo, null: false
      t.integer :user_id, null: false
      t.boolean :new_player, null: false

      t.timestamps
    end
  end
end
