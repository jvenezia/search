require 'rails_helper'

describe Api::V1::AppsController, type: :controller do
  render_views

  let(:json_response) { JSON.parse(response.body) }

  describe 'GET index' do
    let!(:apps) { create_list :app, 2 }
    before { get :index }

    it { should respond_with :success }
    it { expect(json_response.size).to eq 2 }
    it { expect(json_response.first['name']).to eq apps.first.name }
  end

  describe 'POST create' do
    let(:request) { post :create, params: {app: {name: app.name, category: app.category, link: app.link, rank: app.rank}} }

    context 'app is valid' do
      let(:app) { build :app }

      before { request }

      it { should respond_with :created }
      it { expect(json_response['id']).to eq App.last.id }
      it { expect(json_response['name']).to eq app.name }
      it { expect(json_response['category']).to eq app.category }
      it { expect(json_response['link']).to eq app.link }
      it { expect(json_response['rank']).to eq app.rank }
    end

    context 'app is not valid' do
      let(:app) { build :app, name: nil }

      before { request }

      it { should respond_with :unprocessable_entity }
      it { expect(json_response['name']).to be_empty }
      it { expect(json_response['category']).to eq app.category }

      it { expect(json_response['errors']).not_to be_empty }
    end
  end

  describe 'DELETE destroy' do
    let(:app) { create :app }

    before { delete :destroy, params: {id: app.id} }

    it { should respond_with :no_content }
    it { expect(response.body).to be_empty }
  end
end