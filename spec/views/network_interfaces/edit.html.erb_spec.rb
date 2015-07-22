require 'rails_helper'

RSpec.describe 'network_interfaces/edit.html.erb', type: :view do
  before do
    @network_interface = create :network_interface
    @networkable = @network_interface.networkable
    render
  end

  it 'provides a text field to change the name' do
    expect(rendered).to have_field 'Name', with: @network_interface.name
  end

  it 'provides a text field to change the MAC address' do
    expect(rendered).to have_field 'MAC address', with: @network_interface.mac_address
  end

  it 'provides a text field to change the IPv4 address' do
    expect(rendered).to have_field 'IPv4 address', with: @network_interface.ipv4_address
  end

  it 'provides a selection to change the IPv4 netmask' do
    expect(rendered).to have_field 'IPv4 netmask', with: @network_interface.ipv4_netmask
  end

  it 'provides a selection to change the IPv6 address' do
    expect(rendered).to have_field 'IPv6 address', with: @network_interface.ipv6_address
  end

  it 'provides a text field to change the IPv6 prefix' do
    expect(rendered).to have_field 'IPv6 prefix', with: @network_interface.ipv6_prefix
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
