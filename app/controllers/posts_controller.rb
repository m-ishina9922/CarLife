class PostsController < ApplicationController
  def new
    #formオブジェクトのインスタンスを使う
    @post = current_user.posts.new
    @tags = Tag.all           #サイドバータグ表示用
    @user = current_user
    10.times { @post.processimages.build }
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      #@post_form.save_post #バリデーション結果、エラーなしの場合true,エラーありの場合falseを返す
      flash[:notice] = "投稿に成功しました。"
     redirect_to posts_path
    else
     flash.now[:notice] = "投稿に失敗しました"
     render :new
    end
  end

  def index
    @posts = Post.all
    user_id = current_user.id
    @user = User.find(user_id)
    @tags = Tag.all
    @favorites = Favorite.all

  end

  def show
    @post = Post.find(params[:id])
    user_id = current_user.id
    @user = User.find(user_id)
    @post_tags = @post.tags
    @post_comment = PostComment.new
    @tags = Tag.all           #サイドバータグ表示用

  end

  def destroy
    @post = Post.find(params[:id])
    @post.user.id == current_user.id
    @post.destroy
    redirect_to posts_path
  end

  def search_tag
    @tags = Tag.find(params[:tag_id])#検索されたタグを受け取り代入
    @posts = @tags.posts.all          #検索されたタグに紐づくpostを表示
    user_id = current_user.id        #サイドバーのユーザー表示用
    @user = User.find(user_id)
    @tags = Tag.all           #サイドバータグ表示用
  end



  private


  def post_params
    params.require(:post).permit(
      :title,
      :reference_site,
      :products_used,
      :tag_string,
      processimages_attributes: [:text, :image]
      )
  end

end


