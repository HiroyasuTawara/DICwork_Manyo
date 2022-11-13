class Rename < ActiveRecord::Migration[6.1]
  def change
    rename_column :label_tasks, :tasks_id, :task_id
  end
end
