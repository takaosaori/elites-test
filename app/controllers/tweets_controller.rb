class TweetsController < ApplicationController
    
    def index
      @input_tweet = Tweet.new
    end
    
    def show
      @tweet = Tweet.find(params[:id])
    end
   
    def create
      tweet = Tweet.new
      tweet.attributes = tweet_params
      tweet.user_id = current_user.id
      if tweet.valid? # バリデーションチェック
        tweet.save!
        redirect_to action: :index
      else
        @input_tweet = Tweet.new(tweet_params)
        flash[:alert] = tweet.errors.full_messages
        render action: :index
      end
    end
    
    def edit
      @tweet = Tweet.find(params[:id])
    end
    
    def update
     @tweet = Tweet.find(params[:id])
    #  tweet = Tweet.find(params[:id])
     @tweet.attributes = tweet_params
       if @tweet.valid? # バリデーションチェック
          @tweet.save!
          redirect_to action: :show
       else
         flash[:alert] = @tweet.errors.full_messages
         render action: :show
       end
    end
    
    def destroy
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
      redirect_to action: :index
    end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
    
end
