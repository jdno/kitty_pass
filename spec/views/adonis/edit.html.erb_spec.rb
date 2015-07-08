require 'rails_helper'

RSpec.describe 'adonis/edit.html.erb', type: :view do
  before :all do
    @adonis = create :adonis
    assign :adonis, @adonis
  end

  before :each do
    render
  end

  it 'provides a text field to change the hostname' do
    expect(rendered).to have_field 'Hostname', with: @adonis.hostname
  end

  it 'provides a text field to change the identifier' do
    expect(rendered).to have_field 'Identifier', with: @adonis.identifier
  end

  it 'provides a text field to change the inventory number' do
    expect(rendered).to have_field 'Inventory number', with: @adonis.inventory_number
  end

  it 'provides a selection to change the model' do
    expect(rendered).to have_selector 'select#model_id'
  end

  it 'provides a selection to change the status' do
    expect(rendered).to have_selector 'select#status_id'
  end

  it 'provides a selection to change the location' do
    expect(rendered).to have_selector 'select#location_id'
  end

  it 'provides a text field to change the IPv4 gateway' do
    expect(rendered).to have_field 'IPv4 gateway', with: @adonis.ipv4_gateway
  end

  it 'provides a text field to change the IPv6 gateway' do
    expect(rendered).to have_field 'IPv6 gateway', with: @adonis.ipv6_gateway
  end

  it 'provides a text field to change the root password' do
    expect(rendered).to have_field 'Root password', with: @adonis.root_password
  end

  it 'provides a text field to change the admin password' do
    expect(rendered).to have_field 'Admin password', with: @adonis.admin_password
  end

  it 'provides a text field to change the deploy password' do
    expect(rendered).to have_field 'Deploy password', with: @adonis.deploy_password
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save'), adonis_path(@adonis)
  end
end
