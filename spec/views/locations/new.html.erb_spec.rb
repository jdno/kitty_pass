require 'rails_helper'

RSpec.describe 'locations/new.html.erb', type: :view do
  before do
    render
  end

  it 'provides a text field to set the name' do
    expect(rendered).to have_field 'Name'
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
