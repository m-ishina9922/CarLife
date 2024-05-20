class PostsController < ApplicationController
  def new
    @post_form = PostsForm.new

  end

  def create
    @post_form = PostsForm.new(post_form_params)

    if @post_form.save_post
     redirect_to posts_path
    else
     render :new
    end
  end

  def index
    @posts_form = PostsForm.all
  end

  def show
    @post_form = PostForm.find(params[:id])
    #byebug
    @processimage = @post.processimage
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post .id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.user.id == current_user.id
    @post.destroy
    redirect_to posts_path, notice: '削除しました'
  end

  private

  def post_params
    params.require(:post).permit(
      :reference_site,
      :products_used,
      :title,
      processimages_attributes: [:text, :id])
  end

  def post_form_params
    params.require(:posts_form).permit(:title, :reference_site, :products_used, :text)
  end
end
