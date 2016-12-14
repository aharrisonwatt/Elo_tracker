class CreateTournoments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.integer :game_id, null: false
      t.string :bracket, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
