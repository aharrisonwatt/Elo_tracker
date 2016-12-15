class AddGameIdToPlacings < ActiveRecord::Migration[5.0]
  def change
    add_column :placings, :game_id, :integer, null: false
  end
end
