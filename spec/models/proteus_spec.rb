require 'rails_helper'

RSpec.describe Proteus, type: :model do
  before { @proteus = build :proteus }
  subject { @proteus }

  context 'validations' do
    it { should respond_to :hostname }
    it { should respond_to :identifier }
    it { should respond_to :serial_number }
    it { should respond_to :inventory_number }
    it { should respond_to :root_password }
    it { should respond_to :ipv4_gateway }
    it { should respond_to :ipv6_gateway }

    it { should respond_to :location }
    it { should respond_to :model }
    it { should respond_to :status }

    it { should be_valid }
  end

  describe 'without a hostname' do
    before { @proteus.hostname = '' }
    it { should_not be_valid }
  end

  describe 'with a hostname that is already taken' do
    before do
      proteus_with_dup_name = @proteus.dup
      proteus_with_dup_name.save!
    end

    it { should_not be_valid }
  end

  describe 'with a hostname in mixed case' do
    before do
      @proteus.hostname = 'MiXeD'
      @proteus.save!
    end

    it 'should be saved as lower case' do
      expect(@proteus.reload.hostname).to eq 'mixed'
    end
  end

  describe 'with a hostname with invalid characters' do
    it 'should not be valid' do
      invalid_hostnames = %w(dns\ example.com dns@example.com dns!.example.com)
      invalid_hostnames.each do |invalid_hostname|
        @proteus.hostname = invalid_hostname
        expect(@proteus).to_not be_valid
      end
    end
  end

  describe 'with a hostname with valid characters' do
    it 'should be valid' do
      valid_hostnames = %w(dns.example.com dns1.example.com dns.s1.example.com example.com)
      valid_hostnames.each do |valid_hostname|
        @proteus.hostname = valid_hostname
        expect(@proteus).to be_valid
      end
    end
  end

  describe 'without an identifier' do
    before { @proteus.identifier = '' }
    it { should_not be_valid }
  end

  describe 'with an identifier that is already taken' do
    before do
      proteus_with_dup_identifier = @proteus.dup
      proteus_with_dup_identifier.save!
    end

    it { should_not be_valid }
  end

  describe 'with an identifier in mixed case' do
    before do
      @proteus.identifier = 'MiXeD'
      @proteus.save!
    end

    it 'should be saved as upper case' do
      expect(@proteus.reload.identifier).to eq 'MIXED'
    end
  end

  describe 'without a root password' do
    before { @proteus.root_password = '' }
    it { should_not be_valid }
  end

  describe 'without an IPv4 gateway' do
    before { @proteus.ipv4_gateway = '' }
    it { should be_valid }
  end

  describe 'with an IPv4 gateway in invalid format' do
    it 'should not be valid' do
      invalid_gateways = %w(1 2.2 3.3.3 4.4.4.4. 5.5.5.5.5 a.b.c.d 1-2-3-4)
      invalid_gateways.each do |gateway|
        @proteus.ipv4_gateway = gateway
        expect(@proteus).to_not be_valid
      end
    end
  end

  describe 'without an IPv6 gateway' do
    before { @proteus.ipv6_gateway = '' }
    it { should be_valid }
  end

  describe 'with an IPv6 gateway in invalid format' do
    it 'should not be valid' do
      invalid_gateways = %w(ff02::ff::1)
      invalid_gateways.each do |gateway|
        @proteus.ipv6_gateway = gateway
        expect(@proteus).to_not be_valid
      end
    end
  end
end
