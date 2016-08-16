class Api::MatchesController < ApplicationController
  def index
    @matches = Match.all
    render 'index'
  end

  def create
  end

  def patch
  end

  def show
  end

  private
  def match_params
    params.require(:match).permit(:player1_id, :player2_id, :game_id, :winner)
  end
end
