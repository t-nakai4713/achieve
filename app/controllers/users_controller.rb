class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :set_user, only: [:show, :followed, :follower]

  def index
    @users = User.all
  end

  def show
   @followedusers = @user.followed_users
   @followerusers = @user.followers
  end

  private
   # idをキーとして値を取得するメソッド
   def set_user
     @user = User.find(params[:id])
   end

end
