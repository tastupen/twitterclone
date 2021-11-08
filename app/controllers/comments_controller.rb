class CommentsController < ApplicationController
    def create
        @tweet = Tweet.find(params[:tweet_id])
        #投稿に紐づいたコメントを作成
        @comment = @tweet.comments.build(comment_params)
        @comment.user_id = current_user.id
        @comment.save
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to request.referer
    end
    
    private
    def comment_params
        params.require(:comment).permit(:content, :tweet_id, :user_id)
    end
end
