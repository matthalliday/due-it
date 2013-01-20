class ChangeDueDateFormatToDatetime < ActiveRecord::Migration
  def self.up
   change_column :tasks, :due_date, :datetime
  end

  def self.down
   change_column :tasks, :due_date, :date
  end
end
