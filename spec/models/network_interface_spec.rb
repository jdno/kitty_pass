require 'rails_helper'
require_relative '../support/factory_girl'

RSpec.describe NetworkInterface, type: :model do
  before { @interface = build :network_interface }
  subject { @interface }

  context 'validations' do
    it { should respond_to :name }
    it { should respond_to :mac_address }
    it { should respond_to :ipv4_address }
    it { should respond_to :ipv4_netmask }
    it { should respond_to :ipv6_address }
    it { should respond_to :ipv6_prefix }

    it { should respond_to :networkable }

    it { should be_valid }
  end

  describe 'without a name' do
    before { @interface.name = '' }
    it { should_not be_valid }
  end

  describe 'with a name that is not unique for one server' do
    before do
      duplicated_interface = @interface.dup
      duplicated_interface.save!
    end
    it { should_not be_valid }
  end

  describe 'with a name that is not unique for multiple servers' do
    before do
      duplicated_interface = @interface.dup
      duplicated_interface.networkable = create :adonis
      duplicated_interface.save!
    end
    it { should be_valid }
  end

  describe 'without an IPv4 address' do
    before { @interface.ipv4_address = @interface.ipv4_netmask = '' }
    it { should be_valid }
  end

  describe 'with an IPv4 address in invalid format' do
    it 'should not be valid' do
      invalid_addresses = %w(1 2.2 3.3.3 4.4.4.4. 5.5.5.5.5 a.b.c.d 1-2-3-4)
      invalid_addresses.each do |address|
        @interface.ipv4_address = address
        expect(@interface).to_not be_valid
      end
    end
  end

  describe 'with an IPv4 address but no netmask' do
    before { @interface.ipv4_netmask = '' }
    it { should_not be_valid }
  end

  describe 'with an IPv4 netmask in invalid format' do
    it 'should not be valid' do
      invalid_netmasks = %w(1 2.2 3.3.3 4.4.4.4. 5.5.5.5.5 a.b.c.d 1-2-3-4)
      invalid_netmasks.each do |netmask|
        @interface.ipv4_netmask = netmask
        expect(@interface).to_not be_valid
      end
    end
  end

  describe 'with an IPv4 netmask but no address' do
    before { @interface.ipv4_address = '' }
    it { should_not be_valid }
  end

  describe 'without an IPv6 address' do
    before { @interface.ipv6_address = @interface.ipv6_prefix = nil }
    it { should be_valid }
  end

  describe 'with an IPv6 address in invalid format' do
    it 'should not be valid' do
      invalid_addresses = %w(ff02::ff::1)
      invalid_addresses.each do |address|
        @interface.ipv6_address = address
        expect(@interface).to_not be_valid
      end
    end
  end

  describe 'with an IPv6 address but no prefix' do
    before { @interface.ipv6_prefix = '' }
    it { should_not be_valid }
  end

  describe 'with an IPv6 prefix in invalid format' do
    it 'should not be valid' do
      invalid_prefixs = %w(-1 129)
      invalid_prefixs.each do |prefix|
        @interface.ipv6_prefix = prefix
        expect(@interface).to_not be_valid
      end
    end
  end

  describe 'with an IPv6 prefix but no address' do
    before { @interface.ipv6_address = '' }
    it { should_not be_valid }
  end

  describe 'without a server' do
    before { @interface.networkable = nil }
    it { should_not be_valid }
  end
end
