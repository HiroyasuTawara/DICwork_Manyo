class TasksController < ApplicationController
  def index
    @tasks = Task.all
    
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
        #.search_label(params[:search][:label_id])
    end

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
    respond_to do |format|
      if @task.update(task_params)
        format.html {redirect_to tasks_path, notice: "タスクを更新しました。"}
        format.js
      else
        format.html {render :edit, status: :unprocessable_entity}
        format.js { render :errors }
      end
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
    params.require(:task).permit(:name, :priolity, :status, :note, :expired_at)
  end
  
end
