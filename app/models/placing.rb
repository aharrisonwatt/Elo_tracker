class Placing < ApplicationRecord
  validates :user_id, :tournament_id, :placement, :game_id, presence: true

  belongs_to :user
  belongs_to :tournament
  belongs_to :game
end
