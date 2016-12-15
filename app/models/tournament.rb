class Tournament < ApplicationRecord
  validates :name, :game_id, :bracket, :date, presence: true
  
  has_many :matches
  belongs_to :game
end
