class Api::RatingsController < ApplicationController
  def index
    @ratings = Rating.generate_rating_object
    render 'index'
  end

  def show
    @rating = Rating.find(params[:id])
    render 'show'
  end
end

#for each game find the latest Rating for each User
#Rating
