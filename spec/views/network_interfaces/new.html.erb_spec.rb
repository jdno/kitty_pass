require 'rails_helper'

RSpec.describe 'network_interfaces/new.html.erb', type: :view do
  before do
    @networkable = create :adonis
    @network_interface = NetworkInterface.new(networkable: @adonis)
    render
  end

  it 'provides a text field to set the name' do
    expect(rendered).to have_field 'Name'
  end

  it 'provides a text field to set the MAC address' do
    expect(rendered).to have_field 'MAC address'
  end

  it 'provides a text field to set the IPv4 address' do
    expect(rendered).to have_field 'IPv4 address'
  end

  it 'provides a selection to set the IPv4 netmask' do
    expect(rendered).to have_field 'IPv4 netmask'
  end

  it 'provides a selection to set the IPv6 address' do
    expect(rendered).to have_field 'IPv6 address'
  end

  it 'provides a text field to set the IPv6 prefix' do
    expect(rendered).to have_field 'IPv6 prefix'
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
