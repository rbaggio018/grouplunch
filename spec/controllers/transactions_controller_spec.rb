require 'spec_helper'

describe TransactionsController do
  let(:current_user) { FactoryGirl.create(:user) }
  before { sign_in current_user }

  describe 'GET#new' do

    it 'assigns @transaction' do
      get :new
      expect(assigns(:transaction)).not_to be_nil
    end

    context 'params[:source_email] exists' do
      let(:source) { FactoryGirl.create(:user) }

      it 'loads @transaction.source' do
        get :new, source_email: source.email
        expect(assigns(:transaction).source).to eq(source)
      end
    end
  end

  describe 'POST#create' do
    let!(:source) { FactoryGirl.create(:user) }

    let(:transaction_params) {
      {
        source: { email: source.email },
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

    it 'associates transaction and current_user' do
      post :create, transaction: transaction_params
      expect(Transaction.last.destination).to eq(current_user)
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
      before { transaction_params[:source][:email] = "" }

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