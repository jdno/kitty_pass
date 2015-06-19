require 'rails_helper'

RSpec.describe 'static_pages/settings.html.erb', type: :view do
  before :all do
    @models = 5.times.collect { create :model }
    assign :models, @models

    @statuses = 5.times.collect { create :status }
    assign :statuses, @statuses
  end

  before :each do
    render
  end

  it 'lists all models' do
    @models.each do |model|
      expect(rendered).to have_content model.name
      expect(rendered).to have_content model.eol
    end
  end

  it 'has a link to create a new model' do
    expect(rendered).to have_link 'Create new model', new_model_path
  end

  it 'lists all statuses' do
    @statuses.each do |status|
      expect(rendered).to have_content status.name
    end
  end

  it 'has a link to create a new status' do
    expect(rendered).to have_link 'Create new status', new_status_path
  end
end
