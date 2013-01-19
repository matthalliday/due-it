class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  attr_accessible :description, :name

  validates :description, length: { maximum: 500 }
  validates :name, presence: :true, uniqueness: :true, length: { in: 2..64 }

  default_scope -> { order('name ASC') }

  def to_param
    [id, name.parameterize].join('-')
  end
end
