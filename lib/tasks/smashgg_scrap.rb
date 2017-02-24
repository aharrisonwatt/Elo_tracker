require 'net/http'
require 'json'
require 'rest-client'
require_relative 'seed_data.rb'
require_relative 'add_tournament_info.rb'

def add_tournoment(slug)
  url_start = 'https://api.smash.gg/tournament/'
  url_end = '?expand[]=event&expand[]=phase&expand[]=groups&expand[]=entrants'

  url = url_start + slug.to_s + url_end
  response = RestClient.get(url)
  puts(JSON.parse(response)['entities']['tournament']['name'])
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
  tournament = seed_smashgg_tournament_info(object)
  tournament_object = JSON.parse(object)['entities']
  players_hash = {}
  game_name = tournament_object['videogame'][0]['name']
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
    seed_data(player_1, player_2, winner, score, game_name, date, tournament)
  end

  Rating.update_users_rank
end

# add_tournoment('smash-of-the-titans-2-1')
# add_tournoment('smash-of-the-titans-3-1')
# add_tournoment('smash-of-the-titans-4')
# add_tournoment('smash-of-the-titans-5')
# add_tournoment('smash-of-the-titans-6')
# add_tournoment('smash-of-the-titans-7')
# add_tournoment('smash-of-the-titans-8')
# add_tournoment('smash-of-the-titans-9')
# add_tournoment('smash-of-the-titans-10')
# add_tournoment('smash-of-the-titans-11')
# add_tournoment('smash-of-the-titans-12')
# add_tournoment('smash-of-the-titans-13')
# add_tournoment('smash-of-the-titans-14')
# add_tournoment('smash-of-the-titans-15-special-pre-genesis-4-foundry')
# add_tournoment('smash-of-the-titans-16')
# add_tournoment('smash-of-the-titans-18')
# add_tournoment('smash-of-the-titans-19')
