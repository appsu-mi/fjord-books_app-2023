# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_login

  private

  def require_login
    return if current_user

    flash[:error] = 'このページにアクセスするにはログインが必要です'
    redirect_to new_user_session_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit({ roles: [] },
                         :email, :password, :password_confirmation, :current_password, :postal_code, :name, :address, :self_introduction)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit({ roles: [] }, :name, :email, :password, :password_confirmation)
    end
  end
end
