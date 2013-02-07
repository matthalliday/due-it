class RemovePriorityFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :priority, :string
  end

  def down
    add_column :tasks, :priority, :string
  end
end
