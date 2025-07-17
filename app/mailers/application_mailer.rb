class ApplicationMailer < ActionMailer::Base
  default from: 'takami_japan08@live.jp' # ここは後でご自身のメールアドレスに変更してください
  layout 'mailer'
end