class User < ActiveRecord::Base
  include Clearance::User

  has_many :projects, -> { order(name: :asc) }, dependent: :destroy
  has_many :tasks, through: :projects
end
