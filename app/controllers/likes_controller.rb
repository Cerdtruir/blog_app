class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @post = @user.posts.find(params[:post_id])
    Like.create(author: @user, post: @post)
    redirect_to user_post_path(@user, @post)
  end
end
