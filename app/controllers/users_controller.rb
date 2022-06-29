class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @three_posts = @user.show_3_posts
    @all_posts = @user.posts
  end
end
