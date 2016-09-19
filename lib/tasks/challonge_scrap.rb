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
        player_1 = players_hash[match['match']['player1_id']]
        player_2 = players_hash[match['match']['player2_id']]
        game = tournament_object['tournament']['game_name']
        winner_id = players_hash[match['match']['winner_id']]

        player_1_user = User.find_by(username: player_1)
        player_2_user = User.find_by(username: player_2)

        player_1_user = create_user(player_1) if player_1_user == nil
        player_2_user = create_user(player_2) if player_2_user == nil

        if winner_id == player_1
          winner_id = player_1_user.id
        else
          winner_id = player_2_user.id
        end

        match = Match.create(
          { player1_id: player_1_user.id,
            player2_id: player_2_user.id,
            game_id: Game.find_by(name: game).id,
            winner: winner_id
          })

        match.record_results
      end
    end
  end

end

private

def create_user(username)
    User.create({username: username, password: 'default password'})
end

def remove_player_tag(name)
  player_tag = name.split("|").map(&:strip).last
  return player_tag.split('(').first if player_tag.include?('(')
  return player_tag
  #doesn't work for TAG|TAG NAME NAME NAME and TAG|NAME
  # return name.split(' ').last if name.include?(' ')
end
