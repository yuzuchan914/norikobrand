# app/mailers/order_mailer.rb
class OrderMailer < ApplicationMailer
  default to: "takami_japan08@live.jp", from: "no-reply@noriko-brand.com"

  def notify_new_order(order)
    @order = order
    @tweet = order.tweet
    mail(subject: "【のりこブランド】新しい注文がありました")
  end
end