class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :player1_id, null: false
      t.integer :player2_id, null: false
      t.integer :game_id, null: false
      t.integer :winner

      t.timestamps
    end
  end
end
