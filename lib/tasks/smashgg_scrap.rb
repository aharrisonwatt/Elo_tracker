require 'net/http'
require 'json'
require 'rest-client'

def create_tournoment_file
  url_start = 'https://api.smash.gg/tournament/churning-the-butter-'
  url_end = '?expand[]=event&expand[]=phase&expand[]=groups&expand[]=entrants'

  url = url_start + '85' + url_end
  response = RestClient.get(url)

  open("../assets/tournament_smashgg_sf.json","a") do |f|
      f.puts(response)
  end

  puts response

end

def seed_smashgg_data
  url_start = 'https://api.smash.gg/phase_group/'
  url_end = '?expand[]=sets'
  File.open("/Users/andrewwatt/Desktop/CA/Elo_Rater/lib/assets/tournament_smashgg_sf.json", 'r') do |f|
    f.each_line.with_index do |line, i|
      puts i + 1
      tournament_object = JSON.parse(line)
      players_hash = {}
      game_name = tournament_object['entities']['event']['name'].split('Singles').map(&:strip).first

      tournament_object['entities']['player'].each do |player|
        id = player['id']
        player_name = player['gamerTag']
        players_hash[id] = player_name
      end

      phase_group_id = tournament_object['entities']['groups'][0]['id']
      url = url_start + phase_group_id.to_s + url_end
      response = JSON.parse(RestClient.get(url))

      response['entities']['sets'].each do |set|
        # next if set['entrant2Id'] == null
        # player_1
        # score
        # winner_id
      end

      puts response['entities']['sets'][0]['entrant2Id']
    end
  end
end


seed_smashgg_data
