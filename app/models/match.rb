class Match < ApplicationRecord
  validates :player1_id, :player2_id, :game_id, presence: true

  belongs_to :game
  belongs_to :tournament

  def record_results
    #don't record results if match doesn't have a winner
    return if self.winner == nil

    #find both players ratings
    player1_ratings = Rating.where("user_id = ? AND game_id = ?", self.player1_id, self.game.id)
    player2_ratings = Rating.where("user_id = ? AND game_id = ?", self.player2_id, self.game.id)

    #if they don't have a rating generate a new one
    player1_ratings = [generate_rating(self.player1_id, self.game_id, self.date)] if player1_ratings.count == 0
    player2_ratings = [generate_rating(self.player2_id, self.game_id, self.date)] if player2_ratings.count == 0

    #get their most current rating
    player1_current_rating = player1_ratings.sort.last
    player2_current_rating = player2_ratings.sort.last

    #define players elo
    player1_elo = player1_current_rating.elo
    player2_elo = player2_current_rating.elo

    #parse out score
    #score = [player1_score, player2_score]
    score = self.score.split('-').map(&:to_i)

    games_played = score.inject(&:+)

    if score[0] && score[1] #check to make sure score exists
      player1_current_rating.update_rating(player2_elo, score[0], player1_ratings.count, games_played, self.date)
      player2_current_rating.update_rating(player1_elo, score[1], player2_ratings.count, games_played, self.date)
    end
  end

  def generate_rating(player_id, game_id, date)
    Rating.create({
      game_id: game_id,
      elo: 1400,
      user_id: player_id,
      new_player: true,
      date: date
    })
  end

  def players
    [self.player1_id, self.player2_id]
  end
end
