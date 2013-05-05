require 'spec_helper'

describe User do
  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:tasks).through(:projects) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }

  it { should_not allow_value('robot').for(:email) }
  it { should allow_value('test@email.com').for(:email) }

  it { should validate_confirmation_of(:password) }

  it { should ensure_length_of(:username).is_at_most(16) }
  it { should ensure_length_of(:password).is_at_least(4) }

  it { should_not allow_mass_assignment_of(:salt) }
  it { should_not allow_mass_assignment_of(:crypted_password) }
  it { should_not allow_mass_assignment_of(:remember_me_token) }
  it { should_not allow_mass_assignment_of(:reset_password_token) }
  it { should_not allow_mass_assignment_of(:activation_state) }
  it { should_not allow_mass_assignment_of(:activation_code) }
end
