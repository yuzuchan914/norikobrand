class NewsController < ApplicationController
  before_action :set_news, only: [:show]
  before_action :authenticate_admin!, only: [:show, :edit, :update, :destroy]


  # GET /news or /news.json

  def edit
  @new = News.find(params[:id])
  end

  def update
   @new = News.find(params[:id])
   if @new.update(news_params)
    redirect_to news_path(@new), notice: "ニュースを更新しました"
   else
    render :edit
   end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
   redirect_to news_index_path, notice: "ニュースを削除しました"
  end

  def index
    @news = News.order(created_at: :desc)
  end

  # GET /news/1 or /news/1.json
  def show
    @news = News.find(params[:id])
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # POST /news or /news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: "News was successfully created." }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def news_params
      params.require(:news).permit(:title, :content, :image, :remove_image)
    end

    def authenticate_admin!
     unless user_signed_in? && (current_user.email == "takami_japan08@live.jp" || current_user.email == "masayan090909@@")
     redirect_to root_path, alert: "管理者以外はアクセスできません"
     end
   end
end
