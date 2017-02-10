class Api::UsersController < ApplicationController
  def index
    @users = User.all
    render 'index'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      render "api/users/show"
    else
      @errors = @user.errors.full_messages
      render "api/shared/error", status: 422
    end
  end

  def show
    username = params[:id]
    username = clean_username(username)
    user = User.find_by_username(username)
    @user = user.generate_player_info

    if @user
      render "api/users/show"
    else
      @errors = @user.errors.full_messages
      render "api/shared/error", status: 422
    end
  end

  def compare
    game = params[:game_name]
    username = clean_username(params[:username])
    opponent = clean_username(params[:opponent])
    user = User.find_by_username(username)
    @user = user.generate_match_history(opponent, game)
    if @user
      render "api/users/compare"
    else
      @errors = @user.errors.full_messages
      render "api/shared/error", status: 422
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :username)
  end

  def clean_username(username)
    username = username.sub!.sub!('*', '.') if username.include?('*')
    username
  end
end
