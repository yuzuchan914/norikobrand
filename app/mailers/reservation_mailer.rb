class ReservationMailer < ApplicationMailer
  default to: "takami_japan08@live.jp"
  default from: "no-reply@example.com"  # 適宜変更してください

  def send_reservation_email
    @reservation = params[:reservation]
    mail(subject: "新しい予約がありました（#{@reservation[:name]}様）")
  end
end