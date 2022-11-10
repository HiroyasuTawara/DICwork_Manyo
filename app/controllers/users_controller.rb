class UsersController < ApplicationController
  skip_before_action :login_required, only:[:new, :create]


  def show
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path
    end
  end

  def new
    @user = User.new
    if logged_in?
      redirect_to root_path
    end
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
    @user.destroy
    redirect_to root_path, notice: "アカウントを削除しました。" 
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirm)
  end
end
