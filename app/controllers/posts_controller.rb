class PostsController < ApplicationController
  def new
    #formオブジェクトのインスタンスを使う
    @post_form = PostsForm.new


  end

  def create
    @post_form = PostsForm.new(post_form_params)
    @post_form.user_id = current_user.id
    if @post_form.save_post
     redirect_to posts_path
    else
     render :new
    end
  end

  def index
    @posts = Post.all
    @post_tags = Tag.all

  end

  def show
    @post = Post.find(params[:id])
    #@postに紐づいたtag取得
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_form_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.user.id == current_user.id
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(
      :reference_site,
      :products_used,
      :title)
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
      )
  end

end


