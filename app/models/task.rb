class Task < ActiveRecord::Base
  belongs_to :project

  attr_accessible :description, :due_date, :estimate, :name, :priority

  validates :description, length: { maximum: 500 }
  validates :due_date, presence: :true
  validates :priority, presence: :true,
                       inclusion: { in: %w(low normal high) }
  validates :name, presence: :true,
                   length: { maximum: 256 }
end
