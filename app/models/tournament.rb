class Tournament < ApplicationRecord
  has_many :matches
  belongs_to :game
end
