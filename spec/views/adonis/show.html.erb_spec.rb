require 'rails_helper'

RSpec.describe 'adonis/show.html.erb', type: :view do
  before :all do
    @adonis = create :adonis
    assign :adonis, @adonis
  end

  before :each do
    render
  end

  it 'has the hostname' do
    expect(rendered).to have_content @adonis.hostname
  end

  it 'has a link to edit the server' do
    expect(rendered).to have_link t('views.adonis.edit'), edit_adonis_path(@adonis)
  end

  it 'has a link to delete the server' do
    expect(rendered).to have_link t('views.adonis.delete'), adonis_path(@adonis)
  end

  it 'lists the server\'s network interfaces' do
    @adonis.network_interfaces.each do |interface|
      expect(rendered).to have_content interface.name
      expect(rendered).to have_content interface.mac_address
      expect(rendered).to have_content interface.ipv4_address
      expect(rendered).to have_content interface.ipv4_netmask
      expect(rendered).to have_content interface.ipv6_address
      expect(rendered).to have_content interface.ipv6_prefix
    end
  end

  it 'lists the server\'s IPv4 gateway' do
    expect(rendered).to have_content @adonis.ipv4_gateway
  end

  it 'lists the server\'s IPv6 gateway' do
    expect(rendered).to have_content @adonis.ipv6_gateway
  end

  it 'lists the server\'s root password' do
    expect(rendered).to have_content @adonis.root_password
  end

  it 'lists the server\'s admin password' do
    expect(rendered).to have_content @adonis.admin_password
  end

  it 'lists the server\'s deploy password' do
    expect(rendered).to have_content @adonis.deploy_password
  end

  it 'lists the server\'s id' do
    expect(rendered).to have_content @adonis.id
  end

  it 'lists the server\'s identifier' do
    expect(rendered).to have_content @adonis.identifier
  end

  it 'lists the server\'s inventory_number' do
    expect(rendered).to have_content @adonis.inventory_number
  end

  it 'lists the server\'s model' do
    expect(rendered).to have_content @adonis.model.name if @adonis.model.present?
  end

  it 'lists the server\'s status' do
    expect(rendered).to have_content @adonis.status.name if @adonis.status.present?
  end

  it 'lists the server\'s last update' do
    expect(rendered).to have_content l @adonis.updated_at, format: :long
  end
end
