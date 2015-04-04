require 'rails_helper'

RSpec.describe Status, type: :model do
  before { @status = Status.new(name: 'Test') }
  subject { @status }

  context 'validations' do
    it { should respond_to :name }
    it { should be_valid }
  end

  describe 'without a name' do
    before { @status.name = '' }
    it { should_not be_valid }
  end

  describe 'with a name that is already taken' do
    before do
      status_with_dup_name = @status.dup
      status_with_dup_name.save!
    end

    it { should_not be_valid }
  end
end
