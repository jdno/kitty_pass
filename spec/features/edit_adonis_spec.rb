require 'rails_helper'

RSpec.feature 'Edit Adonis', type: :feature do
  before do
    sign_in_user
    @adonis = create :adonis
    visit edit_adonis_path @adonis
  end

  scenario 'User fills out the form correctly' do
    within '.edit_adonis' do
      fill_in 'Hostname', with: 'changed.example.com'
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-success'
    expect(page).to have_content I18n.t 'controllers.application.update.successful', identifier: 'changed.example.com'
  end

  scenario 'User fills out the form incorrectly' do
    within '.edit_adonis' do
      fill_in 'Hostname', with: ''
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-error'
  end
end
