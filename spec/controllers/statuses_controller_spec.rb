require 'rails_helper'

RSpec.describe StatusesController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    it 'renders the #new template' do
      expect(response).to render_template :new
    end

    it 'returns http success' do
      expect(response).to have_http_status :success
    end
  end

  describe 'POST #create' do
    describe 'with valid data' do
      it 'creates the status' do
        expect { post :create, status: attributes_for(:status) }.to change { Status.count }.by 1
      end

      it 'adds a message to the flash' do
        post :create, status: attributes_for(:status)
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects back to the settings page' do
        post :create, status: attributes_for(:status)
        expect(response).to redirect_to settings_path
      end
    end

    describe 'with invalid data' do
      it 'does not create the status' do
        expect { post :create, status: { name: '' } }.to_not change { Status.count }
      end

      it 'adds a message to the flash' do
        post :create, status: { name: '' }
        expect(flash[:error]).to_not be_nil
      end

      it 'renders the #new template' do
        post :create, status: { name: '' }
        expect(response).to render_template :new
      end

      it 'returns http success' do
        post :create, status: { name: '' }
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'GET #edit' do
    describe 'for an existing status' do
      before do
        @status = create :status
        get :edit, id: @status.id
      end

      it 'assigns the requested status to @status' do
        expect(assigns(:status)).to eq @status
      end

      it 'renders the #edit form' do
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        expect(response).to have_http_status :success
      end
    end

    describe 'for a non-existing status' do
      before do
        get :edit, id: 0
      end

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects back to the settings page' do
        expect(response).to redirect_to settings_path
      end
    end
  end

  describe 'PATCH #update' do
    describe 'for an existing status' do
      before { @status = create :status }

      describe 'with valid updates' do
        before do
          patch :update, id: @status.id, status: { name: 'Changed' }
        end

        it 'updates the status' do
          expect(@status.reload.name).to eq 'Changed'
        end

        it 'adds a message to the flash' do
          expect(flash[:success]).to_not be_nil
        end

        it 'redirects to the settings page' do
          expect(response).to redirect_to settings_path
        end
      end

      describe 'with invalid updates' do
        before do
          patch :update, id: @status.id, status: { name: '' }
        end

        it 'adds a message to the flash' do
          expect(flash[:error]).to_not be_nil
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to edit_status_path @status
        end
      end
    end

    describe 'for a non-existing status' do
      before { patch :update, id: 0, status: { name: 'Status 0' } }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the settings page' do
        expect(response).to redirect_to settings_path
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing status' do
      before :each do
        @status = create :status
      end

      it 'destroys the status' do
        expect { delete :destroy, id: @status.id }.to change { Status.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @status.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the settings page' do
        delete :destroy, id: @status.id
        expect(response).to redirect_to settings_path
      end
    end

    describe 'for a non-existing status' do
      before { delete :destroy, id: 0 }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the settings page' do
        expect(response).to redirect_to settings_path
      end
    end
  end
end
