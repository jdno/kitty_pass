# This module contains a few macros that are useful in controller specs.
module ControllerMacros
  def sign_in_user
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create :user
      user.confirm
      sign_in user
    end
  end
end
