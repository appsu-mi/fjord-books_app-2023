# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_login

  # GET /users
  def index
    @users = User.page(params[:page]).per(5).order(:id)
  end

  # GET /users/{id}
  def show
    @user = User.find(params[:id])
  end
end
