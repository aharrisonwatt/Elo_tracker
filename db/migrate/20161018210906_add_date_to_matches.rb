class AddDateToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :date, :date
    add_column :ratings, :date, :date
  end
end
