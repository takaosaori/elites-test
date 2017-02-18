class TweetsController < ApplicationController
    
    def index
      @input_content = Tweet.new
      @tweet = Tweet.includes(:user).order('updated_at DESC')
    end
   
    def create
      tweet = Tweet.new
      tweet.attributes = tweet_params
      tweet.user_id = current_user.id
      if tweet.valid? # バリデーションチェック
        tweet.save!
      else
        flash[:alert] = tweet.errors.full_messages
      end
      redirect_to action: :index
    end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
    
end
