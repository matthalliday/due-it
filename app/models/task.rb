class Task < ActiveRecord::Base
  belongs_to :project

  attr_accessible :description, :due_date, :estimate, :name, :priority, :status

  validates :description, length: { maximum: 500 }
  validates :due_date, presence: :true
  validates :name, presence: :true, length: { maximum: 256 }
  validates :priority, presence: :true, inclusion: { in: %w(low normal high) }

  scope :complete, -> { where(status: 'complete') }
  scope :incomplete, -> { where(status: 'incomplete') }
  scope :this_week, -> { where(due_date: (Time.now)..(1.week.from_now)) }
  scope :next_week, -> { where(due_date: (1.week.from_now)..(2.weeks.from_now)) }
  scope :this_month, -> { where(due_date: (Time.now)..(1.month.from_now)) }
end
