class Tournament < ApplicationRecord
  validates :name, :game_id, :bracket, :date, presence: true

  has_many :matches
  has_many :placings
  belongs_to :game
end
