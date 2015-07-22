require 'rails_helper'

RSpec.describe 'statuses/new.html.erb', type: :view do
  before do
    render
  end

  it 'provides a text field to set the name' do
    expect(rendered).to have_field 'Name'
  end
end
