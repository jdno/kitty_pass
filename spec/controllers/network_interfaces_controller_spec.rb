require 'rails_helper'

RSpec.describe NetworkInterfacesController, type: :controller do
  sign_in_user

  describe 'GET #new' do
    before do
      @adonis = create :adonis
      get :new, adonis_id: @adonis.id
    end

    it 'renders the #new template' do
      expect(response).to render_template :new
    end

    it 'returns http success' do
      expect(response).to have_http_status :success
    end
  end

  describe 'POST #create' do
    describe 'for an existing server' do
      before { @adonis = create :adonis }

      describe 'with valid data' do
        it 'creates the network interface' do
          expect { post :create, adonis_id: @adonis.id, network_interface: { name: 'eth0' } }
            .to change { NetworkInterface.count }.by 1
        end

        it 'adds a message' do
          post :create, adonis_id: @adonis.id, network_interface: { name: 'eth0' }
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to the server page' do
          post :create, adonis_id: @adonis.id, network_interface: { name: 'eth0' }
          expect(response).to redirect_to adonis_path @adonis
        end
      end

      describe 'with invalid data' do
        before { post :create, adonis_id: @adonis.id, network_interface: { name: '' } }

        it 'adds an error message' do
          expect(flash[:error]).to_not be_nil
        end

        it 'renders the #new template' do
          expect(response).to render_template :new
        end

        it 'returns http success' do
          expect(response).to have_http_status :success
        end
      end
    end

    describe 'for a non-existent adonis' do
      before { post :create, adonis_id: 0, network_interface: { name: 'eth0' } }

      it 'adds an error message' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #edit' do
    describe 'for an existing network interface' do
      before do
        @network_interface = create :network_interface

        get :edit, id: @network_interface.id
      end

      it 'renders the #edit template' do
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        expect(response).to have_http_status :success
      end
    end

    describe 'for a non-existing network interface' do
      before do
        @adonis = create :adonis
        allow(request).to receive(:referer).and_return "/adonis/#{@adonis.id}"

        get :edit, id: 0
      end

      it 'adds an error message' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects back' do
        expect(response).to redirect_to adonis_path @adonis
      end
    end
  end

  describe 'PATCH #update' do
    describe 'for an existing network interface' do
      before do
        @network_interface = create :network_interface
      end

      describe 'with valid updates' do
        before do
          patch :update, id: @network_interface.id, network_interface: { name: 'changed' }
        end

        it 'updates the server' do
          expect(NetworkInterface.find(@network_interface.id).name).to eq 'changed'
        end

        it 'adds a message to the flash' do
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to its server page' do
          expect(response).to redirect_to adonis_path @network_interface.networkable.id
        end
      end

      describe 'with invalid updates' do
        before do
          patch :update, id: @network_interface.id, network_interface: { name: '' }
        end

        it 'adds a message to the flash' do
          expect(flash[:error]).to_not be_nil
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to edit_network_interface_path @network_interface
        end
      end
    end

    describe 'for a non-existing network interface' do
      before { patch :update, id: 0, network_interface: { name: 'changed' } }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing network interface' do
      before :each do
        @network_interface = create :network_interface
      end

      it 'destroys the interface' do
        expect { delete :destroy, id: @network_interface.id }.to change { NetworkInterface.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @network_interface.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the index page' do
        delete :destroy, id: @network_interface.id
        expect(response).to redirect_to adonis_path @network_interface.networkable
      end
    end

    describe 'for a non-existing network interface' do
      before do
        delete :destroy, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
