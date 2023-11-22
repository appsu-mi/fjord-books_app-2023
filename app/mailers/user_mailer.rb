class UserMailer < ApplicationMailer
  default from: 'Devise@example.com'
  def reset_password(email)
    mail(
      subject: 'パスワード再設定メール',
      to: email
      # template_path: '/views/devise/mailer',
      # template_name: 'password_change.html.erb'
    )
  end
end
