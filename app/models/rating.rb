class Rating < ApplicationRecord
  validates :game_id, :elo, :user_id, :new_player, presence: true

  belongs_to :user
  belongs_to :game

  def update_rating(opponets_rating, score, match_count, games_played, date)
    k = k_value(match_count)
    elo = (self.elo + k * (score - expected_score(opponets_rating, games_played))).round

    new_player = true

    Rating.create(
      { game_id: self.game_id,
        elo: elo,
        user_id: self.user_id,
        new_player: new_player,
        date: date
      })
    game = Game.find_by(id: self.game_id)
    update_current_rating(self.user_id, game.name, elo)
  end

  def self.sort_current_ratings
    game_object = {}
    Game.all.each do |game|
      game_object[game.name] = {}
    end

    User.all.each do |user|
      rating_object = JSON.parse(user.current_rating)
      rating_object.each do |game_name, rating|
        game_object[game_name][user.username] = rating
      end
    end
    sorted_game_object = {}

    game_object.keys.each do |game_name|
      sorted_ratings = game_object[game_name].sort_by{|_key, value| value}
      sorted_game_object[game_name] = sorted_ratings.reverse
    end

    sorted_game_object
  end

  def self.generate_rating_object
    rating_object = {
      :users => [],
      :games => {}
    }

    game_object = {}
    Game.all.each do |game|
      game_object[game.name] = {}
    end

    User.all.each do |user|
      user_rating_object = JSON.parse(user.current_rating)
      user_rating_object.each do |game_name, rating|
        game_object[game_name][user.username] = rating
      end
      rating_object[:users] << user.username
    end

    game_object.keys.each do |game_name|
      sorted_ratings = game_object[game_name].sort_by{|_key, value| value}
      rating_object[:games][game_name] = sorted_ratings.reverse
    end

    rating_object
  end

  def self.recalculate_ratings
    Rating.all.delete_all
    User.all.each do |user|
      user.current_rating = '{}'
      user.current_rank = '{}'
      user.save!
    end
    matches = Match.all.sort{ |a, b| a.date <=> b.date}
    matches.each do |match|
      match.record_results
    end
    Rating.update_users_rank
  end


  def self.update_users_rank
    ranking_object = Rating.sort_current_ratings

    ranking_object.keys.each do |game_name|
      ranking_object[game_name].each_with_index do |player, i|
        rank = i + 1
        user = User.find_by(username: player[0])
        user.update_current_rank(game_name, rank)
      end
    end
  end

  private
  def generate_game_object
    game_object = {}
    Game.all.each do |game|
      game_object[game.name] = {}
    end

    game_object
  end

  def expected_score(opponets_rating, games_played)
    games_played * (1.0 / (1.0 + 10**((opponets_rating - self.elo) / 400.0)))
  end

  def update_current_rating(user_id, game_name, elo)
    user = User.find_by(id: user_id)
    debugger unless user
    current_rating = JSON.parse(user.current_rating)
    current_rating[game_name] = elo
    user.current_rating = current_rating.to_json.to_s
    user.save!
  end

  def k_value(match_count)
    return 40 if match_count < 35
    return 20 if self.elo < 1800
    return 10
  end
end
