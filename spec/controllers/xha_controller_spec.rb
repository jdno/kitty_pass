require 'rails_helper'

RSpec.describe XHAController, type: :controller do
  sign_in_user

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
    before do
      @master = create :adonis
      @slave = create :adonis
    end

    describe 'with valid data' do
      it 'creates the XHA' do
        expect { post :create, xha: { master_id: @master.id, slave_id: @slave.id } }.to change { XHA.count }.by 1
      end

      it 'adds a message to the flash' do
        post :create, xha: { master_id: @master.id, slave_id: @slave.id }
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the master\'s #show page' do
        post :create, xha: { master_id: @master.id, slave_id: @slave.id }
        expect(response).to redirect_to adonis_path(@master)
      end
    end

    describe 'with invalid data' do
      it 'does not create the server' do
        expect { post :create, xha: { master_id: @master.id, slave_id: @master.id } }.to_not change { XHA.count }
      end

      it 'adds a message to the flash' do
        post :create, xha: { master_id: @master.id, slave_id: @master.id }
        expect(flash[:error]).to_not be_nil
      end

      it 'renders the #new template' do
        post :create, xha: { master_id: @master.id, slave_id: @master.id }
        expect(response).to render_template :new
      end

      it 'returns http success' do
        post :create, xha: { master_id: @master.id, slave_id: @master.id }
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #edit' do
    describe 'for an existing XHA' do
      before do
        @xha = create :xha
        get :edit, id: @xha.id
      end

      it 'assigns the requested XHA to @xha' do
        expect(assigns(:xha)).to eq @xha
      end

      it 'renders the #edit template' do
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end
    end

    describe 'for a non-existing XHA server' do
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
    describe 'for an existing XHA' do
      before { @xha = create :xha }

      describe 'with valid updates' do
        before do
          @new_master = create :adonis
          patch :update, id: @xha.id, xha: { master_id: @new_master.id }
        end

        it 'updates the XHA' do
          expect(XHA.find(@xha.id).master_id).to eq @new_master.id
        end

        it 'adds a message to the flash' do
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to the master\'s #show page' do
          expect(response).to redirect_to adonis_path @new_master
        end
      end

      describe 'with invalid updates' do
        before do
          patch :update, id: @xha.id, xha: { master_id: 0 }
        end

        it 'adds a message to the flash' do
          expect(flash[:error]).to_not be_nil
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to edit_xha_path @xha
        end
      end
    end

    describe 'for a non-existing XHA' do
      before { patch :update, id: 0, xha: { master_id: 0 } }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the index page' do
        expect(response).to redirect_to adonis_index_path
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing XHA' do
      before :each do
        @xha = create :xha
      end

      it 'destroys the XHA' do
        expect { delete :destroy, id: @xha.id }.to change { XHA.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @xha.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the master\'s page' do
        delete :destroy, id: @xha.id
        expect(response).to redirect_to adonis_path @xha.master
      end
    end

    describe 'for a non-existing XHA' do
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
