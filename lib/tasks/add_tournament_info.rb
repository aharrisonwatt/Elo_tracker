require 'json'
require_relative 'seed_data.rb'

def seed_tournament_data
  File.open("lib/assets/tournament.json", 'r') do |f|
    f.each_line.with_index do |line, i|
      puts i + 1 #keep track file running when seeding data
      seed_challonge_tournament_info(line)
    end
  end
  File.open("lib/assets/tournament_smashgg_sf.json", 'r') do |f|
    f.each_line.with_index do |line, i|
      puts i + 1 #keep track file running when seeding data
      seed_smashgg_tournament_info(line)
    end
  end
end

def seed_challonge_tournament_info(object)
  tournament_object = JSON.parse(object)['tournament']
  game = Game.find_by_name(tournament_object['game_name'])
  tournament = Tournament.create({
      name: tournament_object['name'],
      game_id: game.id,
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
        placement: participant['participant']['final_rank'],
        game_id: game.id
      })
  end
end

def seed_smashgg_tournament_info(object)
  tournament_object = JSON.parse(object)['entities']
  #set game object
  game_name = tournament_object['event'][0]['name'].split('Singles').map(&:strip).first
  game = Game.find_by_name(game_name)
  #set tournament name
  tournament_name = tournament_object['tournament']['name'].split('SFV').map(&:strip).last
  #set bracket
  bracket_slug = tournament_object['tournament']['slug']
  bracket = 'smash.gg/' + bracket_slug
  #set date
  date = (Time.at(tournament_object['tournament']['startAt'])).to_s.split(' ')[0]

  tournament = Tournament.create({
      name: tournament_name,
      game_id: game.id,
      bracket: bracket,
      date: date
    })

  tournament_object['entrants'].each do |entrant|
    username = alias_checker(remove_player_tag(entrant['name']))
    user = User.find_by_username(username)
    user = create_user(username) if user == nil
    Placing.create!({
        user_id: user.id,
        tournament_id: tournament.id,
        placement: entrant['finalPlacement'],
        game_id: game.id
      })
  end

  return tournament
end
