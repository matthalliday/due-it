class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :url, :created_at
  has_many :tasks
  embed :ids

  def url
    project_url(object)
  end
end
