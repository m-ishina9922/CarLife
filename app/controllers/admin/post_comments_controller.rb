class Admin::PostCommentsController < ApplicationController

  def index
    #byebug
    @posts = Post.all
    @post_comments = PostComment.includes(:post).all#コメントの取得がうまくいかない
    @users = User.all
  end
end
