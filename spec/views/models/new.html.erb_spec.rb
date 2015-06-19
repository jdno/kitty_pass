require 'rails_helper'

RSpec.describe 'models/new.html.erb', type: :view do
  before do
    render
  end

  it 'provides a text field to set the name' do
    expect(rendered).to have_field 'Name'
  end

  it 'provides a text field to set the EOL date' do
    expect(rendered).to have_field t 'models.model.eol'
  end
end
