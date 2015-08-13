require 'rails_helper'

RSpec.describe 'adonis/show.html.erb', type: :view do
  before :all do
    @adonis = create :adonis
    @adonis.network_interfaces << create(:network_interface)
    @adonis.location = create :location
    @adonis.model = create :model
    @adonis.status = create :status
    assign :adonis, @adonis
  end

  before :each do
    render
  end

  it 'has the hostname' do
    expect(rendered).to have_content @adonis.hostname
  end

  it 'has a link to edit the server' do
    expect(rendered).to have_link t('views.application.edit', resource: 'Adonis'), edit_adonis_path(@adonis)
  end

  it 'has a link to delete the server' do
    expect(rendered).to have_link t('views.application.delete', resource: 'Adonis'), adonis_path(@adonis)
  end

  it 'lists the server\'s network interfaces' do
    @adonis.network_interfaces.each do |interface|
      expect(rendered).to have_content interface.name
      expect(rendered).to have_content interface.mac_address
      expect(rendered).to have_content interface.ipv4_address
      expect(rendered).to have_content interface.ipv4_netmask
      expect(rendered).to have_content interface.ipv6_address
      expect(rendered).to have_content interface.ipv6_prefix
      expect(rendered).to have_link t('views.application.buttons.delete'), network_interface_path(interface)
      expect(rendered).to have_link t('views.application.buttons.edit'), edit_network_interface_path(interface)
    end
  end

  it 'has a link to create new interfaces' do
    expect(rendered).to have_link t('views.application.create', resource: t('models.adonis.network_interface')),
                                  network_interface_path(@adonis.network_interfaces.first)
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

  it 'lists the server\'s location' do
    expect(rendered).to have_content @adonis.location.name
  end

  it 'lists the server\'s model' do
    expect(rendered).to have_content @adonis.model.name
  end

  it 'lists the server\'s SNMP community' do
    expect(rendered).to have_content @adonis.snmp_community
  end

  it 'lists the server\'s status' do
    expect(rendered).to have_content @adonis.status.name
  end

  it 'lists the server\'s Syslog server' do
    expect(rendered).to have_content @adonis.syslog_server
  end

  it 'lists the server\'s last update' do
    expect(rendered).to have_content l @adonis.updated_at, format: :long
  end
end
