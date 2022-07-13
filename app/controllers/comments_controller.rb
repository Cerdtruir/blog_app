class CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  def index
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:post_id])
    respond_to do |format|
      format.json do
        render json: @post.comments
      end
    end
  end

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @username = current_user.name
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment created successfully'
    else
      flash.notice = 'Error: Comment not created'
      render :new, status: 422
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@comment.post.author, @comment.post), notice: 'Comment deleted successfully'
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(author: @user, post: @post,
                                                 text: "#{@username}: #{params[:comment][:text]}")
  end
end
