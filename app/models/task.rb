class Task < ActiveRecord::Base
  belongs_to :project

  attr_accessible :description, :due_date, :estimate, :name, :priority

  validates :description, length: { maximum: 500 }
  validates :due_date, presence: :true
  validates :priority, presence: :true,
                       inclusion: { in: %w(low normal high) }
  validates :name, presence: :true,
                   length: { maximum: 256 }

  scope :due_this_week, -> { where(due_date: (Time.now)..(1.week.from_now)) }
  scope :due_next_week, -> { where(due_date: (1.week.from_now)..(2.weeks.from_now)) }
  scope :due_this_month, -> { where(due_date: (Time.now)..(1.month.from_now)) }
end
