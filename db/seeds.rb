# TODO: make sure files don't break if game_name == false
# => When setting participants name start to build duplicate names hash
# => alias_hash = {close_username => real_username}
# player_name = alias_hash[playername] if alias_hash[playername]
# new model a user has many alternate_names
# can use that to build the object at the beggining of every seed
def create_user(username)
  User.create({username: username, password: 'default password', current_rating: '{}', current_rank: '{}'})
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

def seed_data(player_1, player_2, winner_id, score, game, date)
  player_1 = alias_checker(player_1)
  player_2 = alias_checker(player_2)

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
      score: score,
      date: date
    })
  match.record_results
end

def alias_checker(tag)
  return nil if tag == nil
  alias_hash = {
    'eg ricky ortiz' => 'Ricki Ortiz',
    'tournamentphil' => 'Casual Phil',
    'casualphil' => 'Casual Phil',
    'causualphil' => 'Casual Phil',
    'casual phil' => 'Casual Phil',
    'ricky ortiz' => 'Ricki Ortiz',
    'mattiepie' => 'MattyPie',
    'mattypie' => 'MattyPie',
    'kelvin' => 'Kelvin Jeon',
    'bjunchained' => 'bjUNCHAINED',
    'bj unchained' => 'bjUNCHAINED',
    'bjunchainched' => 'bjUNCHAINED',
    'nothingman' => 'n0thingman',
    'n0thingman' => 'n0thingman',
    'nothing man' => 'n0thingman',
    'mothingman' => 'n0thingman',
    'dr, doom' => 'Dr.Doom',
    'hoodaman' => 'Hoodaman',
    'julio fuentes' => 'Julio',
    'jsze' => 'Jame',
    'illiterate' => 'Pavocado',
    'pavovado' => 'Pavocado',
    'nacerrrrrrrrrrrr' => 'Nacer',
    'g-dragon' => 'G Dragon'
  }
  return alias_hash[tag.downcase] if alias_hash[tag.downcase] != nil
  return tag
end
#Seed all Challonge Street Fighter Data from File
def seed_sf_challonge
  File.open("lib/assets/tournament.json", 'r') do |f|
    f.each_line.with_index do |line, i|
      puts i + 1 #keep track file running when seeding data
      players_hash = {}
      tournament_object = JSON.parse(line)['tournament']
      date = tournament_object['started_at'].split('T')[0]

      tournament_object['participants'].each do |participant|
        id = participant['participant']['id']
        player_name = remove_player_tag(participant['participant']['name'])

        players_hash[id] = player_name
      end

      tournament_object['matches'].each do |match|
        player_1 = players_hash[match['match']['player1_id']]
        player_2 = players_hash[match['match']['player2_id']]
        game = tournament_object['game_name']
        score = match['match']['scores_csv']
        winner_id = players_hash[match['match']['winner_id']]

        seed_data(player_1, player_2, winner_id, score, game, date)
      end
    end
  end
end

#Seed all SmashGG street Fighter Data from file
def seed_sf_smashgg
  url_start = 'https://api.smash.gg/phase_group/'
  url_end = '?expand[]=sets'
  File.open("lib/assets/tournament_smashgg_sf.json", 'r') do |f|
    f.each_line.with_index do |line, i|
      puts i + 1 #keep track file running when seeding data
      tournament_object = JSON.parse(line)['entities']
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
    end
  end
end

seed_sf_challonge
seed_sf_smashgg
Rating.update_users_rank
