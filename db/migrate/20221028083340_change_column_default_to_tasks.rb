class ChangeColumnDefaultToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :priolity, from: nil, to: 0
    change_column_default :tasks, :status, from: nil, to: 0
  end
end
