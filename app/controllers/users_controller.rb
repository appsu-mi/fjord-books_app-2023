class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    redirect_to users_path, notice: '他ユーザーの登録情報を編集することはできません' unless current_user.id == params[:id].to_i
  end

  def update
    if current_user.update(update_params)
      redirect_to current_user, notice: '登録情報を更新しました'
    else
      render :edit
    end
  end

  private

  def update_params
    params.require(:user).permit(:postal_code, :name, :address, :self_introduction)
  end
end
