require 'rails_helper'

RSpec.feature 'Create Adonis', type: :feature do
  before do
    sign_in_user
    @adonis = attributes_for :adonis
    visit new_adonis_path
  end

  scenario 'User fills out the form correctly' do
    within '.new_adonis' do
      fill_in 'Hostname', with: @adonis[:hostname]
      fill_in 'Identifier', with: @adonis[:identifier]
      fill_in 'Inventory number', with: @adonis[:inventory_number]
      fill_in 'Root password', with: @adonis[:root_password]
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-success'
    expect(page).to have_content I18n.t 'controllers.application.create.successful', resource: 'Adonis'
  end

  scenario 'User leaves out required input fields' do
    within '.new_adonis' do
      fill_in 'Hostname', with: @adonis[:hostname]
      fill_in 'Identifier', with: @adonis[:identifier]
      fill_in 'Inventory number', with: @adonis[:inventory_number]
      # Missing: Root password
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-error'
  end

  scenario 'User fills out a field incorrectly' do
    within '.new_adonis' do
      fill_in 'Hostname', with: ''
      fill_in 'Identifier', with: @adonis[:identifier]
      fill_in 'Inventory number', with: @adonis[:inventory_number]
      fill_in 'Root password', with: @adonis[:root_password]
      click_button 'Save'
    end

    expect(page).to have_css 'div.flash-error'
  end
end
