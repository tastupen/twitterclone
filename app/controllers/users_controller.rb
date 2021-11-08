class UsersController < ApplicationController
    
    def show
        @user = User.find(params[:id])
        @tweets = @user.tweets.order(created_at: :desc)
    end
    
    def followings
        @followings = current_user.followings
        render 'show_follow'
    end
    
    def followers
        @followers = current_user.followers
        render 'show_follower'
    end
end
