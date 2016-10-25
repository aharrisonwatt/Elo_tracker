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
    @user = User.find_by_username(params[:id])
    if @user
      render "api/users/show"
    else
      @errors = @user.errors.full_messages
      render "api/shared/error", status: 422
    end
  end



  private
  def user_params
    params.require(:user).permit(:password, :username)
  end
end
