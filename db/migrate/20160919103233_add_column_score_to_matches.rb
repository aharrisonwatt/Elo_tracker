class AddColumnScoreToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :score, :string
  end
end
