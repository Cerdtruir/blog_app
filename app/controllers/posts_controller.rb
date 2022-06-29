class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @like = Like.new
    @comments = Post.find(params[:id]).comments
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
