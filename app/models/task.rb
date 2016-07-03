class Task < ApplicationRecord
  belongs_to :project

  validates :description, length: { maximum: 500 }
  validates :due_date, presence: :true
  validates :name, presence: :true, length: { maximum: 256 }

  scope :complete, -> { where(status: 'complete') }
  scope :incomplete, -> { where(status: 'incomplete') }
  scope :due_today, -> { where(due_date: Time.zone.now.all_day) }
  scope :upcoming, -> { where(due_date: Time.zone.now.all_week(:sunday)) }
  scope :overdue, -> { where(due_date: (Time.zone.now.at_beginning_of_year)..(Time.zone.now.yesterday.beginning_of_day)) }
end
