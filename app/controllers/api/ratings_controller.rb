class Api::RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    render 'index'
  end

  def show
    @rating = Rating.find(params[:id])
    render 'show'
  end
end
