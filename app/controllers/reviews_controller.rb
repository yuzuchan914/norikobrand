class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

   def index
    # 全ての口コミを、投稿が新しい順に取得する
    # N+1問題を防ぐために、関連するuserとtweetも同時に取得
    @reviews = Review.includes(:user, :tweet).order(created_at: :desc)
  end

  def new
    @review = Review.new
    @review.tweet = Tweet.first
  end

  def create
    @review = current_user.reviews.build(review_params)

    if @review.save
      # 口コミ一覧ページにリダイレクトする
      redirect_to reviews_path, notice: '口コミを投稿しました。'
    else
      # 保存に失敗した場合の処理（例：元のページを再表示）
      @tweet = Tweet.find(params[:review][:tweet_id])
      render 'tweets/show', status: :unprocessable_entity
    end
  end

 private

 def review_params
   # :tweet_idも受け取るように修正
   params.require(:review).permit(:tweet_id, :rating, :comment, :image)
 end
end

