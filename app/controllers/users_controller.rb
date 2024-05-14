class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @post = @user.post
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end

  private
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to "/"
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduct, :car_introduct)
  end

end
