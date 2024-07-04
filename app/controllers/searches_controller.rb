class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @tags = Tag.all           #サイドバータグ表示用
    user_id = current_user.id #サイドバーのユーザー表示用
    @user = User.find(user_id)


    @model = params[:model]    #検索されたモデルを取得して代入
    @word = params[:word]      #検索された単語を取得して代入
    @search = params[:seearch] #検索方法を取得して代入

    if @model == "User"     #モデルがUserだった場合
      @users = User.looks(params[:search], params[:word]) #検索方法と検索単語を代入
    else  #そうでなかった場合
      @posts = Post.looks(params[:search], params[:word]) #検索方法と検索単語を代入
    end

  end

end
