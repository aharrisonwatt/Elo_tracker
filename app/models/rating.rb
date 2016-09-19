class Rating < ApplicationRecord
  validates :game_id, :elo, :user_id, :new_player, presence: true

  belongs_to :user
  belongs_to :game

  def update_rating(opponets_rating, score, match_count, games_played)
    k = k_value(match_count)
    elo = self.elo + k * (score - expected_score(opponets_rating, games_played))

    new_player = true

    Rating.create( {game_id: self.game_id, elo: elo, user_id: self.user_id, new_player: new_player})
  end

  private

  def expected_score(opponets_rating, games_played)
    games_played * (1.0 / (1.0 + 10**((opponets_rating - self.elo) / 400.0)))
  end

  def k_value(match_count)
    return 40 if match_count < 35
    return 20 if self.elo < 2400
    return 10
  end
end
