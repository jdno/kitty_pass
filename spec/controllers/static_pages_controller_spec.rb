require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #settings' do
    before do
      @models = 5.times.collect { create :model }
      @statuses = 5.times.collect { create :status }

      get :settings
    end

    it 'assigns all models to @models' do
      expect(assigns(:models)).to eq @models
    end

    it 'assings all statuses to @statuses' do
      expect(assigns(:statuses)).to eq @statuses
    end

    it 'renders the #settings template' do
      expect(response).to render_template :settings
    end

    it 'returns http success' do
      expect(response).to have_http_status :success
    end
  end
end
