require 'rails_helper'

RSpec.describe 'statuses/edit.html.erb', type: :view do
  before :all do
    @status = create :status
    assign :status, @status
  end

  before :each do
    render
  end

  it 'provides a text field to change the name' do
    expect(rendered).to have_field 'Name', with: @status.name
  end
end
