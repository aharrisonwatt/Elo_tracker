# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# TODO: make sure files don't break if game_name == false
def create_user(username)
    User.create({username: username, password: 'default password', current_rating: '{}'})
end

def remove_player_tag(name)
  player_tag = name.split("|").map(&:strip).last
  player_tag = player_tag.split('(').first if player_tag.include?('(')
  player_tag = player_tag.split('[').map(&:strip).first if player_tag.include?('[')
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
