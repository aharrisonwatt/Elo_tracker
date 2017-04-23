class Api::TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
    render 'index'
  end
end
