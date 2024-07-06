class PostsController < ApplicationController
  def new
    #formオブジェクトのインスタンスを使う
    @post_form = PostsForm.new
    @tags = Tag.all           #サイドバータグ表示用
    user_id = current_user.id #サイドバーのユーザー表示用
    @user = User.find(user_id)


  end

  def create
    #byebug
    @post_form = PostsForm.new(post_form_params)
    @post_form.user_id = current_user.id
    if @post_form.valid?
      @post_form.save_post #バリデーション結果、エラーなしの場合true,エラーありの場合falseを返す
     redirect_to posts_path
    else
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
      :reference_site,
      :products_used,
      :title,
      )
  end

  def post_form_params
    params.require(:posts_form).permit(
      :user_id,
      :title,
      :reference_site,
      :products_used,
      :text1,
      :text2,
      :text3,
      :text4,
      :text5,
      :text6,
      :text7,
      :text8,
      :text9,
      :text10,
      :post_id,
      :name,
      :tag_id,
      :images,
      :image1,
      :image2,
      :image3,
      :image4,
      :image5,
      :image6,
      :image7,
      :image8,
      :image9,
      :image10,
      )
  end

end


