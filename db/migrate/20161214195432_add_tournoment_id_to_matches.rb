class AddTournomentIdToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :tournament_id, :integer
  end
end
