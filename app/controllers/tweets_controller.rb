class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: %i[edit update destroy ]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    @tweet = current_user.tweets.new
    @user = current_user
    @randam = User.order("RANDOM()").limit(2)
  end

  # GET /tweets/1 
  def show
    @tweets = Tweet.find(params[:id])
    @comment = Comment.new
    #新着順で表示
    @comments = @tweets.comments.order(created_at: :desc)
    @randam = User.order("RANDOM()").limit(2)
    @user = current_user
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = current_user.tweets.new(tweet_params)
    @user = current_user
    if @tweet.save
      
    else
        
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = current_user.tweets.find(params[:id])
      redirect_to(tweets_url, alert: "ERROR!!") if @tweet.blank?
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id, images: [])
    end
end
