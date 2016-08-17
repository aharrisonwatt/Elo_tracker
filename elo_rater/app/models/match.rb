class Match < ApplicationRecord
  validates :player1_id, :player2_id, :game_id, presence: true

  belongs_to :game

  def players
    [self.player1_id, self.player2_id]
  end
end
