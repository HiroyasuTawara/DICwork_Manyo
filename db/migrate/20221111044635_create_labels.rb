class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :name, null:false
      t.integer :color, null:false, default: 0
      t.timestamps
    end
  end
end
