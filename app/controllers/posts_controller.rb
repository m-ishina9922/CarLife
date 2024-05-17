class PostsController < ApplicationController
  def new
    @posts_form = PostsForm.new


  end

  def create
    @posts_form = PostsForm.new(posts_form_params)

    if @posts_form.save
     redirect_to posts_path
    else
     render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
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

  def posts_form_params
    params.require(:posts_form).permit(:title, :reference_site, :products_used, text)
  end
end
