require 'spec_helper'

describe UsersController do
  let(:current_user) { FactoryGirl.create(:user) }
  before { sign_in current_user }

  describe 'GET#index' do

    it 'assigns @users' do
      get :index
      expect(assigns(:users)).to eq([current_user])
    end
  end
end