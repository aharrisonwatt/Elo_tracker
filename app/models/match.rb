class Match < ApplicationRecord
  validates :player1_id, :player2_id, :game_id, presence: true

  belongs_to :game

  def players
    [self.player1_id, self.player2_id]
  end

  def record_results
    return if self.winner == nil

    player1_rating = Rating.find(self.player1_id)
    player2_rating = Rating.find(self.player2_id)

    if self.winner == self.player1_id
      player1_rating.update_rating(player2_rating.elo, true)
      player2_rating.update_rating(player1_rating.elo, false)
    else
      player1_rating.update_rating(player2_rating.elo, false)
      player2_rating.update_rating(player1_rating.elo, true)
    end
  end
end

#need and check if they have a rating for the game, if not generate a default starting rating
#I need to update their rating based on if they won or loss for that game
