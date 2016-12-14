require 'net/http'
require 'json'
require 'rest-client'
require_relative 'seed_data.rb'

def add_tournoment(event_number)
  url_start = 'https://api.smash.gg/tournament/sfv-churning-the-butter-'
  url_end = '?expand[]=event&expand[]=phase&expand[]=groups&expand[]=entrants'

  url = url_start + event_number.to_s + url_end
  response = RestClient.get(url)
  puts(response)
  seed_tournoment_object(response)
  open("lib/assets/tournament_smashgg_sf.json","a") do |f|
      f.puts(response)
  end

end

def seed_sf_smashgg
  File.open("lib/assets/tournament_smashgg_sf.json", 'r') do |f|
    f.each_line.with_index do |line, i|
      puts i + 1 #keep track file running when seeding data
      seed_tournoment_object(line)
    end
  end
end

def seed_tournoment_object(object)
  #set url needed for API call and set initial variables
  url_start = 'https://api.smash.gg/phase_group/'
  url_end = '?expand[]=sets'
  tournament_object = JSON.parse(object)['entities']
  players_hash = {}
  game_name = tournament_object['event'][0]['name'].split('Singles').map(&:strip).first
  date = (Time.at(tournament_object['tournament']['startAt'])).to_s.split(' ')[0]

  tournament_object['entrants'].each do |player|
    id = player['id']
    player_name = remove_player_tag(player['name'])

    players_hash[id] = player_name
  end

  phase_group_id = tournament_object['groups'][0]['id']
  url = url_start + phase_group_id.to_s + url_end
  response = JSON.parse(RestClient.get(url))

  response['entities']['sets'].each_with_index do |set, i|
    next unless set['entrant2Id']
    next unless set['entrant1Id']
    player_1 = players_hash[set['entrant1Id']]
    player_2 = players_hash[set['entrant2Id']]
    score = set['entrant1Score'].to_s + '-' + set['entrant2Score'].to_s
    winner = players_hash[set['winnerId']]
    seed_data(player_1, player_2, winner, score, game_name, date)
  end

  Rating.update_users_rank
end

add_tournoment(90)
