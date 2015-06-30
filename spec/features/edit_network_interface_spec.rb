require 'rails_helper'

RSpec.feature 'Edit network interface', type: :feature do
  before do
    @network_interface = create :network_interface
    visit edit_network_interface_path @network_interface
  end

  scenario 'User fills out the form correctly' do
    within '.edit_network_interface' do
      fill_in 'Name', with: 'changed'
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-success'
    expect(page).to have_content I18n.t 'controllers.application.update.successful', identifier: 'changed'
  end

  scenario 'User fills out the form incorrectly' do
    within '.edit_network_interface' do
      fill_in 'Name', with: ''
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-error'
  end
end
