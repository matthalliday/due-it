class Task < ActiveRecord::Base
  attr_accessible :description, :due_date, :estimate, :name, :priority
end
