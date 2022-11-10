class AddValidTasks < ActiveRecord::Migration[6.1]
  def self.up
    change_column_null :tasks, :user_id, false, 20
  end

  def self.down
    change_column_null :tasks, :user_id, true, nil
  end
end
