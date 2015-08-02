require 'rails_helper'

RSpec.describe 'xha/edit.html.erb', type: :view do
  before :all do
    @xha = create :xha
    assign :xha, @xha
  end

  before :each do
    render
  end

  it 'provides a selection to change the master' do
    expect(rendered).to have_selector 'select#xha_master_id'
  end

  it 'provides a selection to change the slave' do
    expect(rendered).to have_selector 'select#xha_slave_id'
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
