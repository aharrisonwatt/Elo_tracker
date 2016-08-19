class Rating < ApplicationRecord
  validates :game_id, :elo, :user_id, :new_player, presence: true

  belongs_to :user
  belongs_to :game

  def update_rating(opponets_rating, win)
    score = win ? 1 : 0
    k = self.k_value

    self.elo += k * (score - self.expected_score(opponets_rating))
    self.save
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
