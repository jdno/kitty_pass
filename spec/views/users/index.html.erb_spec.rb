require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :view do
  before :all do
    @users = 5.times.collect { create :user }
    assign :users, @users
  end

  before :each do
    render
  end

  it 'lists all users' do
    @users.each do |user|
      expect(rendered).to have_content user.name
      expect(rendered).to have_content user.email
    end
  end

  it 'has a link to create a new user' do
    expect(rendered).to have_link t('views.application.create', resource: t('views.application.user')), new_user_path
  end
end
