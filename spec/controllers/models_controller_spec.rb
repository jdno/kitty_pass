require 'rails_helper'

RSpec.describe ModelsController, type: :controller do
  sign_in_user

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
      it 'creates the model' do
        expect { post :create, model: attributes_for(:model) }.to change { Model.count }.by 1
      end

      it 'adds a message to the flash' do
        post :create, model: attributes_for(:model)
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects back to the settings page' do
        post :create, model: attributes_for(:model)
        expect(response).to redirect_to settings_path
      end
    end

    describe 'with invalid data' do
      it 'does not create the model' do
        expect { post :create, model: { name: '' } }.to_not change { Model.count }
      end

      it 'adds a message to the flash' do
        post :create, model: { name: '' }
        expect(flash[:error]).to_not be_nil
      end

      it 'renders the #new template' do
        post :create, model: { name: '' }
        expect(response).to render_template :new
      end

      it 'returns http success' do
        post :create, model: { name: '' }
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'GET #edit' do
    describe 'for an existing model' do
      before do
        @model = create :model
        get :edit, id: @model.id
      end

      it 'assigns the requested model to @model' do
        expect(assigns(:model)).to eq @model
      end

      it 'renders the #edit form' do
        expect(response).to render_template :edit
      end

      it 'returns http success' do
        expect(response).to have_http_status :success
      end
    end

    describe 'for a non-existing model' do
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
    describe 'for an existing model' do
      before { @model = create :model }

      describe 'with valid updates' do
        before do
          patch :update, id: @model.id, model: { name: 'Changed' }
        end

        it 'updates the model' do
          expect(@model.reload.name).to eq 'Changed'
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
          patch :update, id: @model.id, model: { name: '' }
        end

        it 'adds a message to the flash' do
          expect(flash[:error]).to_not be_nil
        end

        it 'redirects to the edit page' do
          expect(response).to redirect_to edit_model_path @model
        end
      end
    end

    describe 'for a non-existing model' do
      before { patch :update, id: 0, model: { name: 'Model 0' } }

      it 'adds a message to the flash' do
        expect(flash[:error]).to_not be_nil
      end

      it 'redirects to the settings page' do
        expect(response).to redirect_to settings_path
      end
    end
  end

  describe 'DELETE #destroy' do
    describe 'for an existing model' do
      before :each do
        @model = create :model
      end

      it 'destroys the model' do
        expect { delete :destroy, id: @model.id }.to change { Model.count }.by(-1)
      end

      it 'adds a message to the flash' do
        delete :destroy, id: @model.id
        expect(flash[:success]).to_not be_nil
      end

      it 'redirects to the settings page' do
        delete :destroy, id: @model.id
        expect(response).to redirect_to settings_path
      end
    end

    describe 'for a non-existing model' do
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
