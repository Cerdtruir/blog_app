class LikesController < ApplicationController
  def create
    if user_signed_in?
      @user = current_user
      @post = @user.posts.find(params[:post_id])
      Like.create(author: @user, post: @post)
      redirect_to user_post_path(@user, @post)
    else
      redirect_to new_user_session_path
    end
  end
end
