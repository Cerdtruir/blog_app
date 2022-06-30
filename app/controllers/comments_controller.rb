class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    if user_signed_in?
      @user = current_user
      @post = @user.posts.find(params[:post_id])
      @comment = Comment.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Post created successfully'
    else
      flash.notice = 'Error: Post not created'
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
                                                 text: "#{current_user.name}: #{params[:comment][:text]}")
  end
end
