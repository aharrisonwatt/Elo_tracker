class CreatePlacings < ActiveRecord::Migration[5.0]
  def change
    create_table :placings do |t|
      t.integer :user_id, null: false
      t.integer :tournament_id, null: false
      t.integer :placement, null: false

      t.timestamps
    end
  end
end
