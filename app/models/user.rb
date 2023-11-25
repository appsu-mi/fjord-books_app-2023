# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # ユーザー情報をupdateする際、パスワードの変更があればcurrent_passwordの入力を必須とする。
  # パスワードの変更がなければcurrent_passwordがなくてもupdate出来る。
  def update_without_current_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
      params.delete(:current_password)
      result = update(params, *options)
    else
      current_password = params.delete(:current_password)

      result =
        if valid_password?(current_password)
          update(params, *options)
        else
          assign_attributes(params, *options)
          valid?
          errors.add(:current_password, current_password.blank? ? :blank : :invalid)
          false
        end
    end
    clean_up_passwords
    result
  end
end
