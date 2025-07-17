class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      # 予約成功時の処理（例：メール送信やリダイレクト）
      redirect_to root_path, notice: "予約が完了しました。ありがとうございます！"
    else
      flash.now[:alert] = "予約に失敗しました。入力内容をご確認ください。"
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :phone, :email, :datetime, :note)
  end
end