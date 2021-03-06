require 'rails_helper'

RSpec.describe ProteusController, type: :controller do
  sign_in_user

  describe 'GET #index' do
    before do
      @proteus = 5.times.collect { create :proteus }
    end

    describe 'without filters' do
      before { get :index }

      it 'assigns all Proteus servers to @proteus' do
        expect(assigns(:proteus)).to match_array @proteus
      end

      it 'renders the #index template' do
        expect(response).to render_template :index
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'with filters' do
      before do
        @model = create :model
        @proteus[0..1].each do |a|
          a.model = @model
          a.save!
        end
        get :index, model_id: @model.id
      end

      it 'assigns all Proteus servers matching the filter' do
        expect(assigns(:proteus)).to match_array @proteus.select { |a| a.model == @model }
      end

      it 'renders the #index template' do
        expect(response).to render_template :index
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #show' do
    describe 'for an existing Proteus server' do
      before do
        @proteus = create :proteus
        get :show, id: @proteus.id
      end

      it 'assigns the requested Proteus to @server' do
        expect(assigns(:proteus)).to eq @proteus
      end

      it 'renders the #show template' do
        expect(response).to render_template :show
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'for a non-existing Proteus server' do
      before do
        get :show, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to proteus_index_path
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
      it 'creates the server' do
        expect { post :create, proteus: attributes_for(:proteus) }.to change { Proteus.count }.by 1
      end

      it 'saves the location' do
        location = create :location
        proteus = attributes_for :proteus
        proteus[:location_id] = location.id

        post :create, proteus: proteus
        expect(Proteus.find_by_hostname!(proteus[:hostname]).location.id).to eq location.id
      end

      it 'saves the model' do
        model = create :model
        proteus = attributes_for :proteus
        proteus[:model_id] = model.id

        post :create, proteus: proteus
        expect(Proteus.find_by_hostname!(proteus[:hostname]).model.id).to eq model.id
      end

      it 'saves the status' do
        status = create :status
        proteus = attributes_for :proteus
        proteus[:status_id] = status.id

        post :create, proteus: proteus
        expect(Proteus.find_by_hostname!(proteus[:hostname]).status.id).to eq status.id
      end

      it 'adds a message to the flash' do
        post :create, proteus: attributes_for(:proteus)
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the server\'s page' do
        @proteus = attributes_for :proteus
        post :create, proteus: @proteus
        expect(response).to redirect_to proteus_path(Proteus.find_by_hostname! @proteus[:hostname])
      end
    end

    describe 'with invalid data' do
      it 'does not create the server' do
        expect { post :create, proteus: { hostname: '' } }.to_not change { Proteus.count }
      end

      it 'adds a message to the flash' do
        post :create, proteus: { hostname: '' }
        expect(flash[:error]).to_not be_nil
      end

      it 'renders the #new template' do
        post :create, proteus: { hostname: '' }
        expect(response).to render_template :new
      end

      it 'returns http success' do
        post :create, proteus: { hostname: '' }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #edit' do
    describe 'for an existing Proteus server' do
      before do
        @proteus = create :proteus
        get :edit, id: @proteus.id
      end

      it 'assigns the requested Proteus to @server' do
        expect(assigns(:proteus)).to eq @proteus
      end

      it 'renders the #edit template' do
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'for a non-existing Proteus server' do
      before :each do
        get :edit, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to proteus_index_path
      end
    end
  end

  describe 'PATCH #update' do
    describe 'for an existing Proteus server' do
      before { @proteus = create :proteus }

      describe 'with valid updates' do
        before do
          @location = create :location
          @model = create :model
          @status = create :status
          proteus_hash = {
            hostname:    'changed',
            location_id: @location.id,
            model_id:    @model.id,
            status_id:   @status.id
          }
          patch :update, id: @proteus.id, proteus: proteus_hash
        end

        it 'updates the hostname' do
          expect(Proteus.find(@proteus.id).hostname).to eq 'changed'
        end

        it 'updates the location' do
          expect(@proteus.reload.location.id).to eq @location.id
        end

        it 'updates the model' do
          expect(@proteus.reload.model.id).to eq @model.id
        end

        it 'updates the status' do
          expect(@proteus.reload.status.id).to eq @status.id
        end

        it 'adds a message to the flash' do
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to the server\'s page' do
          expect(response).to redirect_to proteus_path @proteus
        end
      end

      describe 'with invalid updates' do
        before do
          patch :update, id: @proteus.id, proteus: { hostname: '' }
        end

        it 'adds a message to the flash' do
          expect(flash[:error]).to_not be_nil
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to edit_proteus_path @proteus
        end
      end
    end

    describe 'for a non-existing Proteus server' do
      before { patch :update, id: 0, proteus: { hostname: 'changed' } }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to proteus_index_path
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing Proteus server' do
      before :each do
        @proteus = create :proteus
      end

      it 'destroys the server' do
        expect { delete :destroy, id: @proteus.id }.to change { Proteus.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @proteus.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the index page' do
        delete :destroy, id: @proteus.id
        expect(response).to redirect_to proteus_index_path
      end
    end

    describe 'for a non-existing Proteus server' do
      before do
        delete :destroy, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to proteus_index_path
      end
    end
  end
end
