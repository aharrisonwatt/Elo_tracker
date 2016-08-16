class Match < ApplicationRecord
  validates :player1_id, :player2_id, :game_id, presence: true

end
