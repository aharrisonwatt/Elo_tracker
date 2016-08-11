class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  helper_method :current_user, :signed_in?

  private

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def sign_in(user)
    @current_user = user
    session[:session_token] = user.reset_token!
  end

  def sign_out
    session[:session_token] = nil
    current_user.try(:reset_token!)
    @current_user = nil
  end

end
