class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :projects
  has_many :tasks, :through => :projects

  attr_accessor :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :username

  validates :email, presence: :true, uniqueness: :true, format: { with: /@/ }
  validates :username, presence: :true, uniqueness: :true, length: { maximum: 16 }
  validates :password, presence: :true, confirmation: :true, length: { in: 4..20 }
end
