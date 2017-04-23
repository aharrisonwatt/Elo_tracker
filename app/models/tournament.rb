require 'byebug'

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

  def self.generate_tournaments_object
    #set object that is going to be returned
    tournaments_array = []

    #generate game_key hash for quicker lookup
    game_key = {}
    Game.all.each do |game|
      game_key[game.id] = game.name
    end

    #iterate across all Tournaments to generate information
    Tournament.all.each do |tournament|
      #set tournament_object information that is needed
      tournament_object = {
        :name => tournament.name,
        :game => game_key[tournament.game_id],
        :date => tournament.date,
        :bracket => tournament.bracket,
        :placings => []
      }
      #add placement information
      placings_array = []
      tournament.placings.each do |placing|
        user_name = User.find_by_id(placing.user_id).username
        placings_array << [user_name, placing.placement]
      end

      placings_array.sort_by!{|_key, value| value}
      tournament_object[:placings] = placings_array

      #add tournament_object to tournaments_object
      tournaments_array << tournament_object
    end

    return tournaments_array
  end
end
