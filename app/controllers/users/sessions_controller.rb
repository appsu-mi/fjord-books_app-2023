# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    flash.now[:error] = 'パスワードかメールアドレスが間違っています。'
    super
  end

  private

  # ログアウト時、rootではなくログイン画面へリダイレクトさせる。
  def respond_to_on_destroy
    redirect_to user_session_url
  end
end
