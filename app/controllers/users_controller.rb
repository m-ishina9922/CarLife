class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @post = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:car_image_ids]
      params[:user][:car_image_ids].each do |car_image_id|
        image = @user.car_images.find(car_image_id)
        image.purge #car_image_idを取得してcheckを付けたものを削除
      end
    end
    @user.update(user_params)
    redirect_to user_path
  end

  # 論理削除処理
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_valid: false)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to "/"

  end

  def check
    @user = User.find(current_user.id)
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)

  end

  private


  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to "/"
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduct, :car_introduct, car_images: [])
  end

end
