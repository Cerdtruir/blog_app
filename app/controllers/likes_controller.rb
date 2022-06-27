class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    Like.create(author: @user, post: @post)
    redirect_to user_post_path(@user, @post)
  end
end
