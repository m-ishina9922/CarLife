class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
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
