require 'json'
require_relative 'seed_data.rb'

def seed_tournament_data
  File.open("lib/assets/tournament.json", 'r') do |f|
    f.each_line.with_index do |line, i|
      puts i + 1 #keep track file running when seeding data
      seed_challonge_tournament_object(line)
    end
  end
end

def seed_challonge_tournament_object(object)
  tournament_object = JSON.parse(object)['tournament']
  game = Game.find_by_name(tournament_object['game_name'])
  tournament = Tournament.create({
      name: tournament_object['name'],
      game: game,
      bracket: tournament_object['full_challonge_url'],
      date: tournament_object['started_at'].split('T')[0]
    })

  tournament_object['participants'].each do |participant|
    break if participant['participant']['final_rank'] == nil
    username = alias_checker(remove_player_tag(participant['participant']['name']))
    user_id = User.find_by_username(username).id
    Placing.create!({
        user_id: user_id,
        tournament_id: tournament.id,
        placement: participant['participant']['final_rank']
      })
  end
end

seed_tournament_data
