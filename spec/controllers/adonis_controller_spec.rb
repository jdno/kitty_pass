require 'rails_helper'

RSpec.describe AdonisController, type: :controller do
  sign_in_user

  describe 'GET #index' do
    before do
      @adonis = create :adonis
      get :index
    end

    it 'assigns all Adonis servers to @adonis' do
      expect(assigns(:adonis)).to match_array @adonis
    end

    it 'renders the #index template' do
      expect(response).to render_template :index
    end

    it 'returns http success' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do
    describe 'for an existing Adonis server' do
      before do
        @adonis = create :adonis
        get :show, id: @adonis.id
      end

      it 'assigns the requested Adonis to @server' do
        expect(assigns(:adonis)).to eq @adonis
      end

      it 'renders the #show template' do
        expect(response).to render_template :show
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'for a non-existing Adonis server' do
      before do
        get :show, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to adonis_index_path
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
        expect { post :create, adonis: attributes_for(:adonis) }.to change { Adonis.count }.by 1
      end

      it 'adds a message to the flash' do
        post :create, adonis: attributes_for(:adonis)
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the server\'s page' do
        @adonis = attributes_for :adonis
        post :create, adonis: @adonis
        expect(response).to redirect_to adonis_path(Adonis.find_by_hostname! @adonis[:hostname])
      end
    end

    describe 'with invalid data' do
      it 'does not create the server' do
        expect { post :create, adonis: { hostname: '' } }.to_not change { Adonis.count }
      end

      it 'adds a message to the flash' do
        post :create, adonis: { hostname: '' }
        expect(flash[:error]).to_not be_nil
      end

      it 'renders the #new template' do
        post :create, adonis: { hostname: '' }
        expect(response).to render_template :new
      end

      it 'returns http success' do
        post :create, adonis: { hostname: '' }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #edit' do
    describe 'for an existing Adonis server' do
      before do
        @adonis = create :adonis
        get :edit, id: @adonis.id
      end

      it 'assigns the requested Adonis to @server' do
        expect(assigns(:adonis)).to eq @adonis
      end

      it 'renders the #edit template' do
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'for a non-existing Adonis server' do
      before :each do
        get :edit, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to adonis_index_path
      end
    end
  end

  describe 'PATCH #update' do
    describe 'for an existing Adonis server' do
      before { @adonis = create :adonis }

      describe 'with valid updates' do
        before do
          patch :update, id: @adonis.id, adonis: { hostname: 'changed' }
        end

        it 'updates the server' do
          expect(Adonis.find(@adonis.id).hostname).to eq 'changed'
        end

        it 'adds a message to the flash' do
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to the server\'s page' do
          expect(response).to redirect_to adonis_path @adonis
        end
      end

      describe 'with invalid updates' do
        before do
          patch :update, id: @adonis.id, adonis: { hostname: '' }
        end

        it 'adds a message to the flash' do
          expect(flash[:error]).to_not be_nil
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to edit_adonis_path @adonis
        end
      end
    end

    describe 'for a non-existing Adonis server' do
      before { patch :update, id: 0, adonis: { hostname: 'changed' } }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to adonis_index_path
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing Adonis server' do
      before :each do
        @adonis = create :adonis
      end

      it 'destroys the server' do
        expect { delete :destroy, id: @adonis.id }.to change { Adonis.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @adonis.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the index page' do
        delete :destroy, id: @adonis.id
        expect(response).to redirect_to adonis_index_path
      end
    end

    describe 'for a non-existing Adonis server' do
      before do
        delete :destroy, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to adonis_index_path
      end
    end
  end
end
