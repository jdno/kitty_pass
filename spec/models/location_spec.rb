require 'rails_helper'

RSpec.describe Location, type: :model do
  before { @location = Location.new(name: 'Test Location') }
  subject { @location }

  context 'validations' do
    it { should respond_to :name }
    it { should respond_to :adonis }
    it { should respond_to :proteus }
    it { should be_valid }
  end

  describe 'without a name' do
    before { @location.name = '' }
    it { should_not be_valid }
  end

  describe 'with a name that is too short' do
    before { @location.name = 'a' * (Location::NAME_LENGTH.min - 1) }
    it { should_not be_valid }
  end

  describe 'with a name that is too long' do
    before { @location.name = 'a' * (Location::NAME_LENGTH.max + 1) }
    it { should_not be_valid }
  end

  describe 'with a name with invalid characters' do
    it 'should not be valid' do
      invalid_names = %w(Test.Location Test@Location)
      invalid_names.each do |invalid_name|
        @location.name = invalid_name
        expect(@location).to_not be_valid
      end
    end
  end

  describe 'with a name with valid characters' do
    it 'should be valid' do
      valid_names = %w(Test\ Location Test_Location Test1Location)
      valid_names.each do |valid_name|
        @location.name = valid_name
        expect(@location).to be_valid
      end
    end
  end

  describe 'with a name that is already taken' do
    before do
      location_with_dup_name = @location.dup
      location_with_dup_name.save!
    end

    it { should_not be_valid }
  end
end
