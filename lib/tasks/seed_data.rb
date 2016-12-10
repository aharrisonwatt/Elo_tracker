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
    'dr, doom' => 'Dr Doom',
    'dr.doom' => 'Dr Doom',
    'hoodaman' => 'Hoodaman',
    'julio fuentes' => 'Julio',
    'jsze' => 'Jame',
    'illiterate' => 'Pavocado',
    'pavovado' => 'Pavocado',
    'nacerrrrrrrrrrrr' => 'Nacer',
    'g-dragon' => 'G Dragon',
    'pavocado' => 'Pavocado',
    's6 jabdrunk' => 'Jabdrunk',
    'pesto88' => 'Pesto88',
    'el cubanoloco' => 'El Cubano Loco',
    'birdnotice' => 'Burn Notice',
    'burnnotice' => 'Burn Notice',
    'dm_drdoom' => 'Dr Doom',
    'andy' => 'Andy',
    'jabdrunk' => 'Jabdrunk'
  }
  return alias_hash[tag.downcase] if alias_hash[tag.downcase] != nil
  return tag
end

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
