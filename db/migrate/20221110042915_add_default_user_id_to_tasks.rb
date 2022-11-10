class AddDefaultUserIdToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :user_id, form:nil, to:"0"
  end
end
