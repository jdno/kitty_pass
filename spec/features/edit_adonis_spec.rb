require 'rails_helper'

RSpec.feature 'Edit Adonis', type: :feature do
  before do
    @adonis = create :adonis
    visit edit_adonis_path @adonis
  end

  scenario 'User fills out the form correctly' do
    within '.edit_adonis' do
      fill_in 'Hostname', with: 'changed.example.com'
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-success'
    expect(page).to have_content I18n.t 'controllers.adonis_controller.update_successful'
  end

  scenario 'User fills out the form incorrectly' do
    within '.edit_adonis' do
      fill_in 'Hostname', with: ''
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-error'
  end
end
