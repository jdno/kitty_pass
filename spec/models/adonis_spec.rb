require 'rails_helper'

RSpec.describe Adonis, type: :model do
  before { @adonis = build :adonis }
  subject { @adonis }

  context 'validations' do
    it { should respond_to :hostname }
    it { should respond_to :identifier }
    it { should respond_to :serial_number }
    it { should respond_to :inventory_number }
    it { should respond_to :root_password }
    it { should respond_to :admin_password }
    it { should respond_to :deploy_password }
    it { should respond_to :ipv4_gateway }
    it { should respond_to :ipv6_gateway }

    it { should respond_to :location }
    it { should respond_to :model }
    it { should respond_to :status }

    it { should respond_to :xha }

    it { should be_valid }
  end

  describe 'without a hostname' do
    before { @adonis.hostname = '' }
    it { should_not be_valid }
  end

  describe 'with a hostname that is already taken' do
    before do
      adonis_with_dup_name = @adonis.dup
      adonis_with_dup_name.save!
    end

    it { should_not be_valid }
  end

  describe 'with a hostname in mixed case' do
    before do
      @adonis.hostname = 'MiXeD'
      @adonis.save!
    end

    it 'should be saved as lower case' do
      expect(@adonis.reload.hostname).to eq 'mixed'
    end
  end

  describe 'with a hostname with invalid characters' do
    it 'should not be valid' do
      invalid_hostnames = %w(dns\ example.com dns@example.com dns!.example.com)
      invalid_hostnames.each do |invalid_hostname|
        @adonis.hostname = invalid_hostname
        expect(@adonis).to_not be_valid
      end
    end
  end

  describe 'with a hostname with valid characters' do
    it 'should be valid' do
      valid_hostnames = %w(dns.example.com dns1.example.com dns.s1.example.com example.com)
      valid_hostnames.each do |valid_hostname|
        @adonis.hostname = valid_hostname
        expect(@adonis).to be_valid
      end
    end
  end

  describe 'without an identifier' do
    before { @adonis.identifier = '' }
    it { should_not be_valid }
  end

  describe 'with an identifier that is already taken' do
    before do
      adonis_with_dup_identifier = @adonis.dup
      adonis_with_dup_identifier.save!
    end

    it { should_not be_valid }
  end

  describe 'with an identifier in mixed case' do
    before do
      @adonis.identifier = 'MiXeD'
      @adonis.save!
    end

    it 'should be saved as upper case' do
      expect(@adonis.reload.identifier).to eq 'MIXED'
    end
  end

  describe 'without a root password' do
    before { @adonis.root_password = '' }
    it { should_not be_valid }
  end

  describe 'without an IPv4 gateway' do
    before { @adonis.ipv4_gateway = '' }
    it { should be_valid }
  end

  describe 'with an IPv4 gateway in invalid format' do
    it 'should not be valid' do
      invalid_gateways = %w(1 2.2 3.3.3 4.4.4.4. 5.5.5.5.5 a.b.c.d 1-2-3-4)
      invalid_gateways.each do |gateway|
        @adonis.ipv4_gateway = gateway
        expect(@adonis).to_not be_valid
      end
    end
  end

  describe 'without an IPv6 gateway' do
    before { @adonis.ipv6_gateway = '' }
    it { should be_valid }
  end

  describe 'with an IPv6 gateway in invalid format' do
    it 'should not be valid' do
      invalid_gateways = %w(ff02::ff::1)
      invalid_gateways.each do |gateway|
        @adonis.ipv6_gateway = gateway
        expect(@adonis).to_not be_valid
      end
    end
  end
end
