class InquiryMailer < ApplicationMailer

  # このファイルでは default 設定は不要なので削除します

  def send_inquiry(inquiry)
    # コントローラーから渡された inquiry の情報を @inquiry という変数に格納します
    @inquiry = inquiry

    # メールを送信するための設定
    mail(
      to:   'takami_japan08@live.jp', # ★★★ ここに管理者（あなた）のメールアドレスを記入 ★★★
      from: @inquiry.email,                  # フォームに入力された人のアドレスを送信元にする
      subject: 'Webサイトからお問い合わせがありました'   # メールの件名
    )
  end

end