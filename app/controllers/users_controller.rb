class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @three_posts = User.find(params[:id]).show_3_posts
    @all_posts = User.find(params[:id]).posts
  end
end
