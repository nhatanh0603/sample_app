class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      login_success user
    else
      flash.now[:danger] = t ".flash_invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private def login_success user
    log_in user
    if params[:session][:remember_me] == Settings.remember_me
      remember(user)
    else
      forget(user)
    end
    redirect_back_or user
  end
end
