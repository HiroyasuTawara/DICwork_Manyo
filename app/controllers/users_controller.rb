class UsersController < ApplicationController
  skip_before_action :login_required, only:[:new, :create]

  def index
    if current_user.admin?
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)  
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "アカウント作成完了/ログインしました" 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.admin
      @user.destroy
    else
      redirect_to users_url, notice: "管理者アカウントは削除できません." 
    end
    redirect_to root_path, notice: "アカウントを削除しました。" 
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirm)
  end
end
