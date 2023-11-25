# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_login

  protected

  # updateアクションで呼ばれるメソッド。models/user.rbに詳細コードがあります。
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end
end