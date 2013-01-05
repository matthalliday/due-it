class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  attr_accessible :description, :name
  validates_presence_of :name
end
