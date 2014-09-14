require 'rails_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:tasks).dependent(:destroy) }
  it { should ensure_length_of(:description).is_at_most(500) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(64) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }

  it "should include id and project name in URL param" do
    project = FactoryGirl.create(:project, id: 1, name: 'Test Project')
    expect(project.to_param).to eq '1-test-project'
  end
end
