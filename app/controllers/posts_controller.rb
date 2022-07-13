class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(:id).page params[:page]

    respond_to do |format|
      format.html
      format.json do
        authenticate_user!
        render json: @posts
      end
    end
  end

  def show
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
    @like = Like.new
  end

  def new
    if user_signed_in?
      @user = current_user
      @post = Post.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully'
    else
      flash.notice = 'Error: Post not created'
      render :new, status: 422
    end
  end

  def destroy
    @post = Post.includes(:comments).find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy
    redirect_to '/', notice: 'Post deleted successfully'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(author: @user, comments_counter: 0, likes_counter: 0)
  end
end
