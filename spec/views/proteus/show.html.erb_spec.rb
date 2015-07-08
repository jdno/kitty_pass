require 'rails_helper'

RSpec.describe 'proteus/show.html.erb', type: :view do
  before :all do
    @proteus = create :proteus
    @proteus.network_interfaces << create(:network_interface)
    assign :proteus, @proteus
  end

  before :each do
    render
  end

  it 'has the hostname' do
    expect(rendered).to have_content @proteus.hostname
  end

  it 'has a link to edit the server' do
    expect(rendered).to have_link t('views.application.edit', resource: 'Proteus'), edit_proteus_path(@proteus)
  end

  it 'has a link to delete the server' do
    expect(rendered).to have_link t('views.application.delete', resource: 'Proteus'), proteus_path(@proteus)
  end

  it 'lists the server\'s network interfaces' do
    @proteus.network_interfaces.each do |interface|
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
    expect(rendered).to have_link t('views.application.create', resource: t('models.proteus.network_interface')),
                                  network_interface_path(@proteus.network_interfaces.first)
  end

  it 'lists the server\'s IPv4 gateway' do
    expect(rendered).to have_content @proteus.ipv4_gateway
  end

  it 'lists the server\'s IPv6 gateway' do
    expect(rendered).to have_content @proteus.ipv6_gateway
  end

  it 'lists the server\'s root password' do
    expect(rendered).to have_content @proteus.root_password
  end

  it 'lists the server\'s id' do
    expect(rendered).to have_content @proteus.id
  end

  it 'lists the server\'s identifier' do
    expect(rendered).to have_content @proteus.identifier
  end

  it 'lists the server\'s inventory_number' do
    expect(rendered).to have_content @proteus.inventory_number
  end

  it 'lists the server\'s location' do
    expect(rendered).to have_content @proteus.location.name if @proteus.location.present?
  end

  it 'lists the server\'s model' do
    expect(rendered).to have_content @proteus.model.name if @proteus.model.present?
  end

  it 'lists the server\'s status' do
    expect(rendered).to have_content @proteus.status.name if @proteus.status.present?
  end

  it 'lists the server\'s last update' do
    expect(rendered).to have_content l @proteus.updated_at, format: :long
  end
end
