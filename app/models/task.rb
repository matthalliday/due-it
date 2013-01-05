class Task < ActiveRecord::Base
  belongs_to :project

  attr_accessible :description, :due_date, :estimate, :name, :priority
  validates_presence_of :due_date, :priority, :name
end
