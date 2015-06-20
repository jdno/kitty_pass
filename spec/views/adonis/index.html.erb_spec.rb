require 'rails_helper'

RSpec.describe 'adonis/index.html.erb', type: :view do
  before :all do
    @adonis = 20.times.collect { create :adonis }
    assign :adonis, @adonis
  end

  before :each do
    render
  end

  it 'lists all Adonis servers' do
    @adonis.each do |adonis|
      expect(rendered).to have_content adonis.hostname
      expect(rendered).to have_content adonis.root_password
      expect(rendered).to have_content adonis.identifier
    end
  end

  it 'has a link to create a new Adonis server' do
    expect(rendered).to have_link t('views.application.create', resource: 'Adonis'), new_adonis_path
  end
end
