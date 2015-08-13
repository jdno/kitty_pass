require 'rails_helper'

RSpec.describe 'adonis/new.html.erb', type: :view do
  before do
    render
  end

  it 'provides a text field to set the hostname' do
    expect(rendered).to have_field 'Hostname'
  end

  it 'provides a text field to set the identifier' do
    expect(rendered).to have_field 'Identifier'
  end

  it 'provides a text field to set the inventory number' do
    expect(rendered).to have_field 'Inventory number'
  end

  it 'provides a selection to set the model' do
    expect(rendered).to have_selector 'select#adonis_model_id'
  end

  it 'provides a selection to set the status' do
    expect(rendered).to have_selector 'select#adonis_status_id'
  end

  it 'provides a selection to set the location' do
    expect(rendered).to have_selector 'select#adonis_location_id'
  end

  it 'provides a text field to set the IPv4 gateway' do
    expect(rendered).to have_field 'IPv4 gateway'
  end

  it 'provides a text field to set the IPv6 gateway' do
    expect(rendered).to have_field 'IPv6 gateway'
  end

  it 'provides a text field to set the root password' do
    expect(rendered).to have_field 'Root password'
  end

  it 'provides a text field to set the admin password' do
    expect(rendered).to have_field 'Admin password'
  end

  it 'provides a text field to set the deploy password' do
    expect(rendered).to have_field 'Deploy password'
  end

  it 'provides a text field to set the SNMP community' do
    expect(rendered).to have_field 'SNMP community'
  end

  it 'provides a text field to set the Syslog server' do
    expect(rendered).to have_field 'Syslog server'
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
