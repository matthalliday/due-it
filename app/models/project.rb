class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :description, length: { maximum: 500 }
  validates :name, presence: :true, uniqueness: { scope: :user_id, case_sensitive: false }, length: { in: 2..64 }

  def to_param
    [id, name.parameterize].join('-')
  end
end
