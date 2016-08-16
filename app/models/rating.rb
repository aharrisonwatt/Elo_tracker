class Rating < ApplicationRecord
  validates :game_id, :elo, :user_id, :new_player, presense: true

  belongs_to :user
  belongs_to :game
end
