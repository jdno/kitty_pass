require 'rails_helper'

RSpec.describe 'proteus/index.html.erb', type: :view do
  before :all do
    @proteus = 20.times.collect { create :proteus }
    assign :proteus, @proteus
  end

  before :each do
    render
  end

  it 'lists all Proteus servers' do
    @proteus.each do |proteus|
      expect(rendered).to have_content proteus.hostname
      expect(rendered).to have_content proteus.root_password
      expect(rendered).to have_content proteus.identifier
    end
  end

  it 'has a link to create a new Proteus server' do
    expect(rendered).to have_link t('views.application.create', resource: 'Proteus'), new_proteus_path
  end
end
