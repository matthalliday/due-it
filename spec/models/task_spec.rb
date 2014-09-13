require 'rails_helper'

describe Task do
  it { should belong_to(:project) }
  it { should validate_presence_of(:due_date) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:description).is_at_most(500) }
  it { should ensure_length_of(:name).is_at_most(256) }

  it "should be ordered by due date by default" do
    task1 = FactoryGirl.create(:task, name: 'Task 1', due_date: Time.now)
    task2 = FactoryGirl.create(:task, name: 'Task 2', due_date: Time.now + 2.weeks)
    task3 = FactoryGirl.create(:task, name: 'Task 3', due_date: Time.now.yesterday)
    expect(Task.all).to eq [task3, task1, task2]
  end
end
