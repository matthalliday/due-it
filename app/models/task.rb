class Task < ActiveRecord::Base
  belongs_to :project

  attr_accessible :description, :due_date, :estimate, :name, :priority

  validates :description, length: { maximum: 500 }
  validates :due_date, presence: :true
  validates :name, presence: :true, length: { maximum: 256 }
  validates :priority, presence: :true, inclusion: { in: %w(low normal high) }

  default_scope -> { order('due_date ASC') }

  scope :complete, -> { where(status: 'complete') }
  scope :incomplete, -> { where(status: 'incomplete') }
  scope :due_today, -> { where(due_date: Time.zone.now.all_day) }
  scope :due_this_week, -> { where(due_date: Time.zone.now.all_week(:sunday)) }
  scope :due_this_month, -> { where(due_date: Time.zone.now.all_month) }
  scope :overdue, -> { where(due_date: (Time.zone.now.beginning_of_quarter)..(Time.zone.now.yesterday.beginning_of_day)) }
end
