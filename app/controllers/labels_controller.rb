class LabelsController < ApplicationController
  def index
    @labels = @current_user.labels
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id
    if @label.save
      redirect_to labels_path, notice:  "ラベルを作成しました"
    else
      render :new
    end
  end

  def edit
    @label = Label.find(params[:id])
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      redirect_to labels_path, notice: "ラベルを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: "ラベルを削除しました"
  end

  private
  def label_params
    params.require(:label).permit(:name, :color)
  end
end