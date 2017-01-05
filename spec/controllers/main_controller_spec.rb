require 'rails_helper'

describe MainController, type: :controller do
  describe 'GET index' do
    before { get :index }

    it { should respond_with :success }
  end
end