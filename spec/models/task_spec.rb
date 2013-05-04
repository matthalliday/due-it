require 'spec_helper'

describe Task do
  it { should belong_to(:project) }

  it { should validate_presence_of(:due_date) }
  it { should validate_presence_of(:name) }

  it { should ensure_length_of(:description).is_at_most(500) }
  it { should ensure_length_of(:name).is_at_most(256) }

  it { should_not allow_mass_assignment_of(:project_id) }
  it { should_not allow_mass_assignment_of(:status) }
end
