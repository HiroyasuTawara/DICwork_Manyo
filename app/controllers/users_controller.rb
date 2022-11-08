class UsersController < ApplicationController
  skip_before_action :login_required, only:[:new, :create]

  def index
    @users = User.all
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
      redirect_to user_path(@user.id), notice: "User was successfully created." 
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
    redirect_to users_url, notice: "User was successfully destroyed." 
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirm)
  end
end
