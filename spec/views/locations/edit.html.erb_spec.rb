require 'rails_helper'

RSpec.describe 'locations/new.html.erb', type: :view do
  before :all do
    @location = create :location
    assign :location, @location
  end

  before :each do
    render
  end

  it 'provides a text field to change the name' do
    expect(rendered).to have_field 'Name' # TODO: , with: @location.name
  end

  it 'provides a save button' do
    expect(rendered).to have_button t('views.application.buttons.save')
  end
end
