# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :require_login

# パスワード再設定の画面
  # GET /resource/password/new
  def new
    super
  end

  # パスワード再設定　メール送るやつ
  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  protected

  def after_resetting_password_path_for(resource)
    super(resource)
  end

   # リセットパスワードの指示を送信した後に使用する path
  def after_sending_reset_password_instructions_path_for(resource_name)
    super(resource_name)
  end
end
