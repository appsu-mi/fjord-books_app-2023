# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_login
end
