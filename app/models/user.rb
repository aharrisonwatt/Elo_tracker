class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :ratings
  has_many :placings

  attr_reader :password

  after_initialize :ensure_session_token

  #Data_generation
  def all_matches(game_id)
    Match.where("player1_id = ? OR player2_id = ?", self.id, self.id)
         .where("game_id = ?", game_id)
  end

  def update_current_rank(game_name, rank)
    current_rank = JSON.parse(self.current_rank)
    current_rank[game_name] = rank
    self.current_rank = current_rank.to_json.to_s
    self.save!
  end

  def generate_player_info
    player_info = {}
    current_rank = JSON.parse(self.current_rank)
    current_ratings = JSON.parse(self.current_rating)

    current_rank.keys.each do |game_name|
      player_info[game_name] = {
        rank: current_rank[game_name],
        rating: current_ratings[game_name],
        ratings: []
      }

      game_id = Game.find_by(name: game_name)
      game_ratings = self.ratings.where("game_id = ?", game_id).sort{ |a, b| a.date <=> b.date}
      seen_dates = Set.new

      game_ratings.each do |rating|
        next if seen_dates.include?(rating.date)
        rating_info = {
          rating: rating.elo,
          date: rating.date
        }

        seen_dates.add(rating.date)
        player_info[game_name][:ratings] << rating_info
      end
    end

    player_info
  end

  def generate_match_history(opponent, game)
    game = Game.find_by_name(game)
    matches = self.all_matches(game.id)
    opponent_id = User.find_by_username(opponent).id
    stats = {
      wins: 0,
      loses: 0,
      last_played: nil,
      won_last: nil
    }

    matches.each do |match|
      next unless match.player1_id == opponent_id || match.player2_id == opponent_id
      match.winner == self.id ? stats[:wins] += 1 : stats[:loses] += 1
      if stats[:last_played] == nil || stats[:last_played] < match.date
        stats[:last_played] = match.date
        if match.winner == self.id
          stats[:won_last] = self.username
        else
          stats[:won_last] = opponent
        end
      end
    end

    stats
  end

  def self.consolidate_users(primary_username, target_username)
    primary_user = User.find_by_username(primary_username)
    target_user = User.find_by_username(target_username)

    return false unless primary_user && target_user

    primary_user.update_placings(target_user)
    primary_user.update_matches(target_user)
    target_user.delete

    return true
  end

  #Auth
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user && user.valid_password?(password)
    user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def update_placings(target_user)
    target_user.placings.each do |placing|
      placing.user_id = self.id
      placing.save!
    end
  end

  def update_matches(target_user)
    Game.all.each do |game|
      target_user.all_matches(game.id).each do |match|
        if match.player1_id == target_user.id
          match.player1_id = self.id
        elsif match.player2_id == target_user.id
          match.player2_id = self.id
        end
        match.save!
      end
    end
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

end
