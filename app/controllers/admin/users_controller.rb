class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました'
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(users_params)
    redirect_to admin_users_path
  end

  private
  def users_params
    params.require(:users).permit(:name, :email)
  end
end
