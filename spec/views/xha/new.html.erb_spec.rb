require 'rails_helper'

RSpec.describe 'xha/new.html.erb', type: :view do
  before do
    render
  end

  it 'provides a selection to set the master' do
    expect(rendered).to have_selector 'select#xha_master_id'
  end

  it 'provides a selection to set the slave' do
    expect(rendered).to have_selector 'select#xha_slave_id'
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
