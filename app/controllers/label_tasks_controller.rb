class LabelTasksController < ApplicationController
  before_action :set_label_task, only: %i[ show edit update destroy ]

  # GET /label_tasks or /label_tasks.json
  def index
    @label_tasks = LabelTask.all
  end

  # GET /label_tasks/1 or /label_tasks/1.json
  def show
  end

  # GET /label_tasks/new
  def new
    @label_task = LabelTask.new
  end

  # GET /label_tasks/1/edit
  def edit
  end

  # POST /label_tasks or /label_tasks.json
  def create
    @label_task = LabelTask.new(label_task_params)

    respond_to do |format|
      if @label_task.save
        format.html { redirect_to label_task_url(@label_task), notice: "Label task was successfully created." }
        format.json { render :show, status: :created, location: @label_task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @label_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /label_tasks/1 or /label_tasks/1.json
  def update
    respond_to do |format|
      if @label_task.update(label_task_params)
        format.html { redirect_to label_task_url(@label_task), notice: "Label task was successfully updated." }
        format.json { render :show, status: :ok, location: @label_task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @label_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /label_tasks/1 or /label_tasks/1.json
  def destroy
    @label_task.destroy

    respond_to do |format|
      format.html { redirect_to label_tasks_url, notice: "Label task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_label_task
      @label_task = LabelTask.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def label_task_params
      params.fetch(:label_task, {})
    end
end
