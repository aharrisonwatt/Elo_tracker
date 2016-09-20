class Api::RatingsController < ApplicationController
  def index
    game = Game.all
    @ratings = []
    game.each do |g|
      game_id = g.id
      users = User.all
      users.each do |user|
        user_id = user.id
        rating = Rating.where("user_id = ? AND game_id = ?", user_id, game_id).last
        @ratings.push(rating) unless rating == nil
      end
    end
    @ratings
    render 'index'
  end

  def show
    @rating = Rating.find(params[:id])
    render 'show'
  end
end

#for each game find the latest Rating for each User
#Rating
