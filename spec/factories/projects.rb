FactoryGirl.define do
  factory :project do
    name             'Test Project'
    description      'A sample project for testing'
    incomplete_tasks 1
    complete_tasks   2
    user_id          1
  end
end
