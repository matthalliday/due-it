class User < ApplicationRecord
  include Clearance::User

  has_many :projects, -> { order(name: :asc) }, dependent: :destroy
  has_many :tasks, through: :projects

  # TODO: is this required by Clearance gem?
  attr_accessor :username
end
