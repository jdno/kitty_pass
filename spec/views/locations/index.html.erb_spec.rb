require 'rails_helper'

RSpec.describe 'locations/index.html.erb', type: :view do
  before :all do
    @locations = 20.times.collect { create :location }
    assign :locations, @locations
  end

  before :each do
    render
  end

  it 'lists all locations' do
    @locations.each do |location|
      expect(rendered).to have_link location.name, location_path(location)
      expect(rendered).to have_content location.adonis.count
    end
  end

  it 'has a link to create a new location' do
    expect(rendered).to have_link t('views.application.create', resource: t('models.adonis.location')),
                                  new_location_path
  end
end
