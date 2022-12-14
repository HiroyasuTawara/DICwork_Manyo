class TasksController < ApplicationController
  before_action :ensure_user, only: %i[ edit update destroy ]
  def index
    @tasks = @current_user.tasks
    @surch_labels = @current_user.labels
    if params[:sort_expired_at]
      @tasks = @tasks.sort_expired_at
    elsif params[:sort_priolity]
      @tasks = @tasks.sort_priolity
    else
      @tasks = @tasks.sort_created_at
    end
  
    if params[:search].present?
      @tasks = @tasks
        .search_status(params[:search][:status])
        .search_name(params[:search][:name])
        .search_label(params[:search][:label_id])
    end

    @tasks = @tasks.page(params[:page]).sort_created_at
  end


  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @labels = current_user.labels
  end

  def edit
    @task = Task.find(params[:id])
    @labels = current_user.labels
  end


  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to task_url(@task), notice: "タスクを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html {redirect_to task_url(@task), notice: "タスクを更新しました。"}
        format.js
      else
        format.html {render :edit, status: :unprocessable_entity}
        format.js { render :errors }
      end
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: "タスクを削除しました。" 
  end


  private
  def ensure_user
    @tasks = current_user.tasks
    @task = @tasks.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(
      :name, :priolity, :status, :note, :expired_at, label_ids: [])
  end
  
end
