# Configure RSpec to include Warden's helpers and set the test mode.
RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end
end

# This module contains useful methods for feature specs.
module FeatureHelpers
  def sign_in_user
    user = FactoryGirl.create(:user)
    user.confirm
    login_as user, scope: :user
  end
end
