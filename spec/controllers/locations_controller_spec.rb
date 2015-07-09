require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  sign_in_user

  describe 'GET #index' do
    before do
      @locations = 5.times.collect { create :location }
      get :index
    end

    it 'lists all locations' do
      expect(assigns(:locations)).to match_array @locations
    end

    it 'renders the #index template' do
      expect(response).to render_template :index
    end

    it 'returns http success' do
      expect(response).to have_http_status :success
    end
  end

  describe 'GET #show' do
    describe 'for an existing location' do
      before do
        @location = create :location
        get :show, id: @location.id
      end

      it 'assigns the requested location to @location' do
        expect(assigns(:location)).to eq @location
      end

      it 'renders the #show template' do
        expect(response).to render_template :show
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'for a non-existing location' do
      before do
        get :show, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to locations_path
      end
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
      it 'creates the location' do
        expect { post :create, location: attributes_for(:location) }.to change { Location.count }.by 1
      end

      it 'adds a message to the flash' do
        post :create, location: attributes_for(:location)
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the location\'s page' do
        @location = attributes_for :location
        post :create, location: @location
        expect(response).to redirect_to location_path(Location.find_by_name! @location[:name])
      end
    end

    describe 'with invalid data' do
      it 'does not create the location' do
        expect { post :create, location: { name: '' } }.to_not change { Location.count }
      end

      it 'adds a message to the flash' do
        post :create, location: { name: '' }
        expect(flash[:error]).to_not be_nil
      end

      it 'renders the #new template' do
        post :create, location: { name: '' }
        expect(response).to render_template :new
      end

      it 'returns http success' do
        post :create, location: { name: '' }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #edit' do
    describe 'for an existing location' do
      before do
        @location = create :location
        get :edit, id: @location.id
      end

      it 'assigns the requested location to @location' do
        expect(assigns(:location)).to eq @location
      end

      it 'renders the #edit template' do
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'for a non-existing location' do
      before :each do
        get :edit, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to locations_path
      end
    end
  end

  describe 'PATCH #update' do
    describe 'for an existing location' do
      before { @location = create :location }

      describe 'with valid updates' do
        before do
          patch :update, id: @location.id, location: { name: 'changed' }
        end

        it 'updates the location' do
          expect(Location.find(@location.id).name).to eq 'changed'
        end

        it 'adds a message to the flash' do
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to the locations\'s page' do
          expect(response).to redirect_to location_path @location
        end
      end

      describe 'with invalid updates' do
        before do
          patch :update, id: @location.id, location: { name: '' }
        end

        it 'adds a message to the flash' do
          expect(flash[:error]).to_not be_nil
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to edit_location_path @location
        end
      end
    end

    describe 'for a non-existing location' do
      before { get :edit, id: 0 }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to locations_path
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing location' do
      before :each do
        @location = create :location
      end

      it 'destroys the location' do
        expect { delete :destroy, id: @location.id }.to change { Location.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @location.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the index page' do
        delete :destroy, id: @location.id
        expect(response).to redirect_to locations_path
      end
    end

    describe 'for a non-existing location' do
      before do
        delete :destroy, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to locations_path
      end
    end
  end
end
