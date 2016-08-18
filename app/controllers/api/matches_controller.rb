class Api::MatchesController < ApplicationController
  def index
    @matches = Match.all
    render 'index'
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      render 'api/matches/show'
    else
      @errors = @match.errors.full_messages
      render 'api/shared/errors', status: 422
    end
  end

  def update
    @match = Match.find(params[:id])
    winner = params[:winner]
    if @match.update(winner: winner)
      @match.record_results
      render 'api/matches/show'
    else
      @errors = @match.errors.full_messages
      render 'api/shared/errors', status: 422
    end
  end

  def show
    @match = Match.find(params[:id])
    render 'api/matches/show'
  end

  private
  def match_params
    params.require(:match).permit(:player1_id, :player2_id, :game_id, :winner)
  end
end
