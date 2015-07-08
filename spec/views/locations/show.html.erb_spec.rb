require 'rails_helper'

RSpec.describe 'locations/show.html.erb', type: :view do
  before :all do
    @location = create :location
    @adonis = 5.times.collect { create(:adonis, location: @location) }
    assign :location, @location
  end

  before :each do
    render
  end

  it 'has the name' do
    expect(rendered).to have_content @location.name
  end

  it 'has a link to edit the location' do
    expect(rendered).to have_link t('views.application.edit', resource: 'Location'), edit_location_path(@location)
  end

  it 'has a link to delete the location' do
    expect(rendered).to have_link t('views.application.delete', resource: 'Location'), location_path(@location)
  end

  it 'lists the location\'s Adonis' do
    @location.adonis.each do |adonis|
      expect(rendered).to have_content adonis.hostname
    end
  end
end
