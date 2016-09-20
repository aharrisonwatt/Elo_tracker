class AddCurrentRatingsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_rating, :string
    add_index :users, :current_rating
  end
end
