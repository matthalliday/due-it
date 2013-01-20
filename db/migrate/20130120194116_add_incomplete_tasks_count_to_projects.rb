class AddIncompleteTasksCountToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :incomplete_tasks, :integer, default: 0

    Project.reset_column_information
    Project.all.each do |p|
      p.update_attribute :incomplete_tasks, p.tasks.incomplete.length
    end
  end

  def self.down
    remove_column :projects, :incomplete_tasks
  end
end
