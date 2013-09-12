FactoryGirl.define do
  factory :task do
    name        'A sample task'
    description 'A sample task for testing'
    estimate    '2 hours'
    due_date    (Time.zone.now + 3.days)
    project_id  1
    status      'incomplete'
  end
end
