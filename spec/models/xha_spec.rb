require 'rails_helper'

RSpec.describe XHA, type: :model do
  before { @xha = build :xha }
  subject { @xha }

  context 'validations' do
    it { should respond_to :master }
    it { should respond_to :slave}
    it { should respond_to :network_interface }

    it { should be_valid }
  end

  describe 'without a master' do
    before { @xha.master = nil }
    it { should_not be_valid }
  end

  describe 'without a slave' do
    before { @xha.slave = nil }
    it { should_not be_valid }
  end

  describe 'with a single server as both the master and slave' do
    before { @xha.master = @xha.slave }
    it { should_not be_valid }
  end

  describe 'with a server that is already part of an XHA' do
    before do
      @second_xha = create :xha
      @second_xha.master = @xha.master
      @second_xha.save!
    end

    it { should_not be_valid }
  end

  describe 'has a network interface' do
    before { @xha.save! }

    it 'after creation' do
      expect(@xha.network_interface).to_not be_nil
      expect(@xha.network_interface.name).to eq "xha_#{@xha.master.hostname}+#{@xha.slave.hostname}"
    end
  end
end
