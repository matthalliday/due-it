require 'spec_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:tasks) }

  it { should ensure_length_of(:description).is_at_most(500) }
  it { should ensure_length_of(:name).is_at_least(2).is_at_most(64) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }

  it { should_not allow_mass_assignment_of(:complete_tasks) }
  it { should_not allow_mass_assignment_of(:incomplete_tasks) }
  it { should_not allow_mass_assignment_of(:user_id) }
end
