class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :set_search

  def set_search
    @q = Tweet.includes(:user).order(created_at: :desc).ransack(params[:q]) #ransackメソッド推奨
    @tweet = @q.result.page(params[:page]).per(10)
  end


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :profile])
  end
end
