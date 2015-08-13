require 'rails_helper'

RSpec.describe 'models/edit.html.erb', type: :view do
  before :all do
    @model = create :model
    assign :model, @model
  end

  before :each do
    render
  end

  it 'provides a text field to change the name' do
    expect(rendered).to have_field 'Name', with: @model.name
  end

  it 'provides a text field to change the EOL date' do
    expect(rendered).to have_field 'End of life' # TODO: , with: @model.eol
  end
end
