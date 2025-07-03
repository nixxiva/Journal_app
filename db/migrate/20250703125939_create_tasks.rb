class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :task_name, null:false
      t.text :definition, null:false
      t.date :due_date, null:false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
