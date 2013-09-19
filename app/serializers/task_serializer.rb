class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :estimate, :due_date, :status, :created_at
end
