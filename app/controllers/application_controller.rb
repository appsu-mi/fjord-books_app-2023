# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?

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

  def after_sign_in_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    user_session_path
  end
end
