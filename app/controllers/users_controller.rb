class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    redirect_to action: "not_found" if @user.nil? # users_not_found_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".flash_success_create"
      redirect_to @user #= redirect_to user_url(@user)
    else
      render :new
    end
  end

  private def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end
end
