require 'rails_helper'

RSpec.feature 'Create network interface', type: :feature do
  before do
    @adonis = create :adonis
    @network_interface = attributes_for :network_interface
    visit new_adonis_network_interface_path @adonis
  end

  scenario 'User fills out the form correctly' do
    within '.new_network_interface' do
      fill_in 'Name', with: @network_interface[:name]
      fill_in 'MAC address', with: @network_interface[:mac_address]
      fill_in 'IPv4 address', with: @network_interface[:ipv4_address]
      fill_in 'IPv4 netmask', with: @network_interface[:ipv4_netmask]
      fill_in 'IPv6 address', with: @network_interface[:ipv6_address]
      fill_in 'IPv6 prefix', with: @network_interface[:ipv6_prefix]
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-success'
    expect(page).to have_content I18n.t 'controllers.application.create.successful', resource:
                                        I18n.t('models.adonis.network_interface')
  end

  scenario 'User leaves out required input fields' do
    within '.new_network_interface' do
      # fill_in 'Name', with: @network_interface[:name]
      fill_in 'MAC address', with: @network_interface[:mac_address]
      fill_in 'IPv4 address', with: @network_interface[:ipv4_address]
      fill_in 'IPv4 netmask', with: @network_interface[:ipv4_netmask]
      fill_in 'IPv6 address', with: @network_interface[:ipv6_address]
      fill_in 'IPv6 prefix', with: @network_interface[:ipv6_prefix]
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-error'
  end

  scenario 'User fills out a field incorrectly' do
    within '.new_network_interface' do
      fill_in 'Name', with: @network_interface[:name]
      fill_in 'MAC address', with: 'not.a.MAC.address'
      fill_in 'IPv4 address', with: @network_interface[:ipv4_address]
      fill_in 'IPv4 netmask', with: @network_interface[:ipv4_netmask]
      fill_in 'IPv6 address', with: @network_interface[:ipv6_address]
      fill_in 'IPv6 prefix', with: @network_interface[:ipv6_prefix]
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-error'
  end
end
