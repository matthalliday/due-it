class Task < ActiveRecord::Base
  attr_accessible :description, :due_date, :estimate, :name, :priority

  validates_presence_of :due_date, :priority, :name
end
