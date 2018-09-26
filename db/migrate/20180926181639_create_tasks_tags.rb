class CreateTasksTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks_tags do |t|
      t.references :task, foreign_key: true
      t.references :tags, foreign_key: true

      t.timestamps
    end
  end
end
