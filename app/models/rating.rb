class Rating < ApplicationRecord
  validates :game_id, :elo, :user_id, :new_player, presence: true

  belongs_to :user
  belongs_to :game

  def update_rating(opponets_rating, win, match_count)
    score = win ? 1 : 0
    k = k_value
    elo = self.elo + k * (score - expected_score(opponets_rating))

    if match_count < 25
      new_player = true
    else
      new_player = false
    end

    Rating.create( {game_id: self.game_id, elo: elo, user_id: self.user_id, new_player: new_player})
  end

  private

  def expected_score(opponets_rating)
    1.0 / (1.0 + 10**((opponets_rating - self.elo) / 400.0))
  end

  def k_value
    return 40 if self.new_player
    return 20 if self.elo < 2400
    return 10
  end
end
