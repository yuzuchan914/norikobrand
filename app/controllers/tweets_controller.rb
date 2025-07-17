class TweetsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def top
    @title = Tweet.first&.title || "ようこそ のりこブランド へ"
    @vision = Tweet.where(name: nil).first
  end

  def index
    @products = Tweet.where.not(name: nil)
  end

  def new
    @product = Tweet.new
  end

  def show
  end

  def create
      tweet = Tweet.new(tweet_params)

      if tweet.save!
        redirect_to :action => "index"
      else
        redirect_to :action => "new"
      end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet), notice: "商品情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "商品を削除しました"
  end

  def top
    @vision = Vision.last 
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end


  def tweet_params
    params.require(:tweet).permit(:title, :body, :name, :price, :description, :image, :remove_image)
  end

  def authenticate_admin!
    unless user_signed_in? && (current_user.email == "takami_japan08@live.jp" || current_user.email == "masayan090909@@")
      redirect_to root_path, alert: "管理者以外はアクセスできません"
    end
  end
end