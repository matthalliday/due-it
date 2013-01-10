class Task < ActiveRecord::Base
  belongs_to :project

  attr_accessible :description, :due_date, :estimate, :name, :priority, :status

  validates :description, length: { maximum: 500 }
  validates :due_date, presence: :true
  validates :name, presence: :true, length: { maximum: 256 }
  validates :priority, presence: :true, inclusion: { in: %w(low normal high) }

  scope :complete, -> { where(status: 'complete') }
  scope :incomplete, -> { where(status: 'incomplete') }
  scope :due_today, -> { where(due_date: (Date.today)) }
  scope :due_this_week, -> { where(due_date: (Time.now.beginning_of_week)..(Time.now.end_of_week)) }
  scope :due_this_month, -> { where(due_date: (Time.now.beginning_of_month)..(Time.now.end_of_month)) }
  scope :overdue, -> { where(due_date: (6.months.ago)..(1.day.ago)) }
end
