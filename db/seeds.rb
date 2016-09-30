# TODO: make sure files don't break if game_name == false
# => When setting participants name start to build duplicate names hash
# => alias_hash = {close_username => real_username}
# player_name = alias_hash[playername] if alias_hash[playername]
# new model a user has many alternate_names
# can use that to build the object at the beggining of every seed
def create_user(username)
    User.create({username: username, password: 'default password', current_rating: '{}'})
end

def remove_player_tag(name)
  player_tag = name.split("|").map(&:strip).last
  return player_tag.split('(').first if player_tag.include?('(')
  if player_tag.include?('[')
    if player_tag[0] == '['
      return player_tag.split(']').map(&:strip).last
    else
      return player_tag.split('[').map(&:strip).first
    end
  end
  return player_tag
end

File.open("/Users/andrewwatt/Desktop/CA/Elo_Rater/lib/assets/tournament.json", 'r') do |f|
  f.each_line.with_index do |line, i|
    puts i + 1
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
      score = match['match']['scores_csv']
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
      game_object = Game.find_by(name: game)
      game_object = Game.create({name: game}) if game_object == nil
      match = Match.create(
        { player1_id: player_1_user.id,
          player2_id: player_2_user.id,
          game_id: game_object.id,
          winner: winner_id,
          score: score
        })
      match.record_results
    end
  end
end
