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

  private
  def login_success user
    if user.activated?
      log_in user
      params[:session][:remember_me] == Settings.remember_me ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = I18n.t "users.account_activation.flash_warning_not_activated"
      redirect_to root_url
    end
  end
end
