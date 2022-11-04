class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    :set_user
  end

  def new
    @user = User.new
  end

  def edit
    :set_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user), notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    :set_user
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    :set_user
    @user.destroy
    redirect_to users_url, notice: "User was successfully destroyed." 
  end

  private
  def user_params
    params.fetch(:user, {})
  end
end
