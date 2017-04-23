class Api::TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.generate_tournaments_object
    render 'index'
  end
end
