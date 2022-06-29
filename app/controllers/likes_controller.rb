class LikesController < ApplicationController
  def create
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    Like.create(author: @user, post: @post)
    redirect_to user_post_path(@user, @post)
  end
end
