require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = build :user }
  subject { @user }

  context 'validations' do
    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }

    it { should be_valid }
  end

  describe 'without a name' do
    before { @user.name = '' }
    it { should_not be_valid }
  end

  describe 'with a name that is already taken' do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.save!
    end
    it { should_not be_valid }
  end

  describe 'without an email address' do
    before { @user.email = '' }
    it { should_not be_valid }
  end
end
