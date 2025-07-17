class OrdersController < ApplicationController
  def new
    @tweet = Tweet.find(params[:tweet_id])  # 購入対象の商品
    @order = Order.new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @order = @tweet.orders.build(order_params)

    if @order.save
      redirect_to root_path, notice: "ご注文ありがとうございました！"
    else
      flash.now[:alert] = "注文に失敗しました。入力内容をご確認ください。"
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :name,
      :address,
      :phone_number,
      :card_number,  # 仮のカード番号欄
      :quantity,
      :message        # メモ欄
    )
  end
end