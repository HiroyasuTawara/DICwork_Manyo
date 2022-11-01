class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: "DESC")
  end


  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end


  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_url(@task), notice: "タスクを作成しました。" 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_url(@task), notice: "タスクを更新しました。" 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url, notice: "タスクを削除しました。" 
  end


  private

  def task_params
    params.require(:task).permit(:name, :priolity, :status, :note)
  end
end
