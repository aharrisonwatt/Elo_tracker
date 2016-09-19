class Match < ApplicationRecord
  validates :player1_id, :player2_id, :game_id, presence: true

  belongs_to :game

  def record_results
    return if self.winner == nil

    player1_ratings = Rating.where("user_id = ? AND game_id = ?", self.player1_id, self.game.id)
    player2_ratings = Rating.where("user_id = ? AND game_id = ?", self.player2_id, self.game.id)

    player1_ratings = [generate_rating(self.player1_id, self.game_id)] if player1_ratings.count == 0
    player2_ratings = [generate_rating(self.player2_id, self.game_id)] if player2_ratings.count == 0

    player1_rating = player1_ratings.sort.last
    player2_rating = player2_ratings.sort.last

    player1_elo = player1_rating.elo
    player2_elo = player2_rating.elo

    score = self.score.split('-').map(&:to_i)
    games_played = score.inject(&:+)
    if score[0]
      player1_rating.update_rating(player2_elo, score[0], player1_ratings.count, games_played)
      player2_rating.update_rating(player1_elo, score[1], player2_ratings.count, games_played)
    end
  end

  def generate_rating(player_id, game_id)
    Rating.create({
      game_id: game_id,
      elo: 1400,
      user_id: player_id,
      new_player: true
    })
  end

  def players
    [self.player1_id, self.player2_id]
  end
end
