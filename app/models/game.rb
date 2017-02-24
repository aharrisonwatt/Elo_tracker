class Game < ApplicationRecord
  validates :name, presence: true

  has_many :matches

  def self.get_game(game_name)
    game = Game.find_by_name(game_name)
    game = Game.create_game(game_name) unless game
    return game
  end

  def self.create_game(game_name)
    Game.create({
        name: game_name
      })
  end
end
