# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!
  def create
    flash.now[:error] = 'パスワードかメールアドレスが間違っています。'
    super
  end
end
