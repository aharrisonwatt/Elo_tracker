class Tournament < ApplicationRecord
  validates :name, :game_id, :bracket, :date, presence: true

  has_many :matches
  has_many :placings
  belongs_to :game

  def self.create_tournament(name, game, bracket_url, date)
    Tournament.create({
        name: name,
        game_id: game.id,
        bracket: bracket_url,
        date: date
      })
  end
end
