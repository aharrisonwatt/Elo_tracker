class Api::RatingsController < ApplicationController
  def index
    @ratings = []
    User.all.each do |u|
      object = JSON.parse(u.current_rating)
      object['username'] = u.username
      @ratings << object
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
