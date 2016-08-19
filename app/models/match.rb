class Match < ApplicationRecord
  validates :player1_id, :player2_id, :game_id, presence: true

  belongs_to :game



  def record_results
    return if self.winner == nil
  
    player1_rating = Rating.where("user_id = ? AND game_id = ?", self.player1_id, self.game.id).take
    player2_rating = Rating.where("user_id = ? AND game_id = ?", self.player2_id, self.game.id).take

    player1_elo = player1_rating.elo
    player2_elo = player2_rating.elo


    if self.winner == self.player1_id
      player1_rating.update_rating(player2_elo, true)
      player2_rating.update_rating(player1_elo, false)
    else
      player1_rating.update_rating(player2_elo, false)
      player2_rating.update_rating(player1_elo, true)
    end
  end

  def generate_rating(player_id)
    Rating.create( {
      game: self.game_id,
      elo: 1400,
      user_id: player_id,
      new_player: true
      })
  end

  def players
    [self.player1_id, self.player2_id]
  end
end

#need and check if they have a rating for the game, if not generate a default starting rating
#I need to update their rating based on if they won or loss for that game
