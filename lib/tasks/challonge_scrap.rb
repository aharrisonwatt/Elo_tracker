require 'net/http'
require 'json'

def save_file
  url = 'https://deadliefoe:IdK414yZ2tLz6vAFS2WDlMz36odipMtmBQWWCxwH@api.challonge.com/v1/tournaments/showdowngg-ChurningTheButter_82.json?include_participants=1&include_matches=1'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  # JSON.parse(response)
  #
  File.open("../assets/tournament.json","w") do |f|
      f.write(response)
  end

  puts response
end

#iterate through tournoment object
def record_matches

  #set up hash correlating to
  File.open("../assets/tournament.json", 'r') do |f|
    f.each_line do |line|
      players_hash = {}
      tournament_object = JSON.parse(line)

      tournament_object['tournament']['participants'].each do |participant|
        id = participant['participant']['id']
        player_name = remove_player_tag(participant['participant']['name'])

        players_hash[id] = player_name
      end

      tournament_object['tournament']['matches'].each do |match|

      end


      puts players_hash
    end
  end

end

def remove_player_tag(name)
  player_tag = name.split("|").map(&:strip).last
  return player_tag.split('(').first if player_tag.include?('(')
  return player_tag
  #doesn't work for TAG|TAG NAME NAME NAME and TAG|NAME
  # return name.split(' ').last if name.include?(' ')
end
