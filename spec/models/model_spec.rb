require 'rails_helper'

RSpec.describe Model, type: :model do
  before { @model = Model.new(name: 'Adonis', eol: Date.new(2017, 04, 01)) }
  subject { @model }

  context 'validations' do
    it { should respond_to :name }
    it { should respond_to :eol }
    it { should respond_to :adonis }
    it { should be_valid }
  end

  describe 'without a name' do
    before { @model.name = '' }
    it { should_not be_valid }
  end

  describe 'with a name that is already taken' do
    before do
      model_with_dup_name = @model.dup
      model_with_dup_name.save!
    end

    it { should_not be_valid }
  end
end
