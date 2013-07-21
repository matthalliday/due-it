require 'spec_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:tasks).dependent(:destroy) }

  it { should ensure_length_of(:description).is_at_most(500) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(64) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }

  it { should_not allow_mass_assignment_of(:complete_tasks) }
  it { should_not allow_mass_assignment_of(:incomplete_tasks) }
  it { should_not allow_mass_assignment_of(:user_id) }

  it "should include id and project name in URL param" do
    project = Project.create(id: 1, name: 'Test Project')
    expect(project.to_param).to eq '1-test-project'
  end

  it "should be ordered alphabetically by default" do
    project1 = Project.create(name: 'Interesting Project')
    project2 = Project.create(name: '1st Rails Project')
    project3 = Project.create(name: 'Awesome Project')
    expect(Project.all).to eq [project2, project3, project1]
  end
end
