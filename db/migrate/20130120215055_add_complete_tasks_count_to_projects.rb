class AddCompleteTasksCountToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :complete_tasks, :integer, default: 0

    Project.reset_column_information
    Project.all.each do |p|
      p.update_attribute :complete_tasks, p.tasks.complete.length
    end
  end

  def self.down
    remove_column :projects, :complete_tasks
  end
end
