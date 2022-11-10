class Admin::UsersController < ApplicationController
  before_action :disallow_non_administrators
  skip_before_action :login_required, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"アカウント作成完了/admin" 
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"アカウント更新完了/admin" 
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.admin
      @user.destroy
    else
      redirect_to users_url, notice: "管理者アカウントは削除できません." 
    end
    redirect_to admin_users_path, notice: "アカウントを削除しました。" 
  end

  private
  def disallow_non_administrators
    redirect_to tasks_path, notice: "このアカウントは管理者専用ページにアクセスできません。" unless current_user.admin == true
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end