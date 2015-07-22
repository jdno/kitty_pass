require 'rails_helper'

RSpec.describe 'proteus/new.html.erb', type: :view do
  before do
    render
  end

  it 'provides a text field to change the hostname' do
    expect(rendered).to have_field 'Hostname'
  end

  it 'provides a text field to change the identifier' do
    expect(rendered).to have_field 'Identifier'
  end

  it 'provides a text field to change the inventory number' do
    expect(rendered).to have_field 'Inventory number'
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
    expect(rendered).to have_field 'IPv4 gateway'
  end

  it 'provides a text field to change the IPv6 gateway' do
    expect(rendered).to have_field 'IPv6 gateway'
  end

  it 'provides a text field to change the root password' do
    expect(rendered).to have_field 'Root password'
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
