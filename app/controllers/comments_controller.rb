class CommentsController < ApplicationController
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

  private

  def comment_params
    params.require(:comment).permit(:text).merge(author: current_user, post: @post,
                                                 text: "#{current_user.name}: #{params[:comment][:text]}")
  end
end
