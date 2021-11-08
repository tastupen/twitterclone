class FindersController < ApplicationController
  def finder
    @user = current_user
    @users = User.search(params[:keyword]).order("RANDOM()").limit(2)
    @tweets = Tweet.search(params[:keyword]).order(created_at: :desc)
  end
end
