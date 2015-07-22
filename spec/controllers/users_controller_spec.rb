require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  sign_in_user

  describe 'GET #index' do
    before do
      @users = [User.first]
      @users += 4.times.collect { create :user }
      get :index
    end

    it 'assigns all users to @users' do
      expect(assigns(:users)).to match_array @users
    end

    it 'renders the #index template' do
      expect(response).to render_template :index
    end

    it 'returns http success' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'renders the #new template' do
      expect(response).to render_template :new
    end

    it 'returns http success' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    describe 'with valid data' do
      it 'creates the user' do
        expect { post :create, user: attributes_for(:user) }.to change { User.count }.by 1
      end

      it 'adds a message to the flash' do
        post :create, user: attributes_for(:user)
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the users\' #index page' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to users_path
      end
    end

    describe 'with invalid data' do
      it 'does not create the user' do
        expect { post :create, user: { name: '' } }.to_not change { User.count }
      end

      it 'adds a message to the flash' do
        post :create, user: { name: '' }
        expect(flash[:error]).to_not be_nil
      end

      it 'renders the #new template' do
        post :create, user: { name: '' }
        expect(response).to render_template :new
      end

      it 'returns http success' do
        post :create, user: { name: '' }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing user' do
      before :each do
        @user = create :user
      end

      it 'destroys the user' do
        expect { delete :destroy, id: @user.id }.to change { User.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @user.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the index page' do
        delete :destroy, id: @user.id
        expect(response).to redirect_to users_path
      end
    end

    describe 'for a non-existing user' do
      before do
        delete :destroy, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to users_path
      end
    end
  end
end
