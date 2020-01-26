class CreateIsFinishTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :is_finish_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.integer :finish_type, null: false

      t.timestamps
    end
  end
end
