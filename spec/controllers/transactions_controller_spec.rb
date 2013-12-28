require 'spec_helper'

describe TransactionsController do

  describe 'GET#new' do

    it 'assigns @transaction' do
      get :new
      expect(assigns(:transaction)).not_to be_nil
    end
  end

  describe 'POST#create' do
    let!(:source) { FactoryGirl.create(:user, name: 'Source') }
    let!(:destination) { FactoryGirl.create(:user, name: 'Destination') }

    let(:transaction_params) {
      {
        source: { name: 'Source' },
        destination: { name: 'Destination' },
        amount: 10.0
      }
    }

    it 'creates a transaction' do
      expect {
        post :create, transaction: transaction_params
      }.to change(Transaction, :count).by(1)
    end

    it 'associates transaction and source' do
      post :create, transaction: transaction_params
      expect(Transaction.last.source).to eq(source)
    end

    it 'associates transaction and destination' do
      post :create, transaction: transaction_params
      expect(Transaction.last.destination).to eq(destination)
    end

    it 'sets the amount' do
      post :create, transaction: transaction_params
      expect(Transaction.last.amount).to eq(10.0)
    end

    it 'directs to users_path' do
      post :create, transaction: transaction_params
      expect(response).to redirect_to users_path
    end

    it 'shows notice' do
      post :create, transaction: transaction_params
      expect(flash[:notice]).not_to be_nil
    end

    context 'not valid' do
      before { transaction_params[:source][:name] = "" }

      it 'does not create a transaction' do
        expect {
          post :create, transaction: transaction_params
        }.to change(Transaction, :count).by(0)
      end

      it 'renders new template' do
        post :create, transaction: transaction_params
        expect(response).to render_template(:new)
      end

      it 'shows error message' do
        post :create, transaction: transaction_params
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end