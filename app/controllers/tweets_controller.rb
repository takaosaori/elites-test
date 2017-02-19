class TweetsController < ApplicationController
    
    def index
      @input_content = Tweet.new
    #   @tweet = Tweet.includes(:user).order('updated_at DESC').page(params[:page]).per(10)
    
    #   @q = Post.order(created_at: :desc).ransack(params[:q])
    #   @posts = @q.result.page(params[:page]).per(10)
      
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
      else
        flash[:alert] = tweet.errors.full_messages
      end
      redirect_to action: :index
    end
    
    def edit
      @input_content = Tweet.find(params[:id])
    end
    
    def update
     @input_content = Tweet.find(params[:id])
    #  tweet = Tweet.find(params[:id])
     @input_content.attributes = tweet_params
       if @input_content.valid? # バリデーションチェック
         @input_content.save!
       else
         flash[:alert] = @input_content.errors.full_messages
       end
       redirect_to action: :show
    end
    
    def destroy
      @input_content = Tweet.find(params[:id])
      @input_content.destroy
      redirect_to action: :index
    end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
    
end
