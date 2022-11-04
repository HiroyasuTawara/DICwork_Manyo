class AddValidation < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :expired_at, false
  end
end
