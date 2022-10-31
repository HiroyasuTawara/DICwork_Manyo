class Add < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :note, false
  end
end
