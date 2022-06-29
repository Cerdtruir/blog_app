class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
    @like = Like.new
  end

  def new
    @user = current_user
    @post = Post.new
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

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(author: @user, comments_counter: 0, likes_counter: 0)
  end
end
