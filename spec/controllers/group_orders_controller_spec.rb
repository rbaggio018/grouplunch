require 'spec_helper'

describe GroupOrdersController do

  describe 'POST#create' do
    let(:order1) { FactoryGirl.create(:order) }
    let(:order2) { FactoryGirl.create(:order) }
    let!(:customer) { FactoryGirl.create(:user, name: "Customer") }

    let(:group_order_params) {
      {
        customer: { name: "Customer" },
        total: 20,
        order_ids: [order1.id, order2.id]
      }
    }

    it 'redirects to user list' do
      post :create, group_order: group_order_params
      expect(response).to redirect_to users_path
    end

    it 'shows notice' do
      post :create, group_order: group_order_params
      expect(flash[:notice]).not_to be_nil
    end

    it 'creates a group order' do
      expect {
        post :create, group_order: group_order_params
      }.to change(GroupOrder, :count).by(1)
    end

    it 'associates group order and orders' do
      post :create, group_order: group_order_params
      expect(GroupOrder.last.orders).to match_array([order1, order2])
    end

    it 'associates group order and customer' do
      post :create, group_order: group_order_params
      expect(GroupOrder.last.customer).to eq(customer)
    end

    it 'updates balances' do
      expect(BalanceCalculator).to receive(:calculate).once
      post :create, group_order: group_order_params
    end

    context 'not valid' do
      before { group_order_params[:customer][:name] = "" }

      it 'does not create group order' do
        expect {
          post :create, group_order: group_order_params
        }.to change(GroupOrder, :count).by(0)
      end

      it 'redirects to order list' do
        post :create, group_order: group_order_params
        expect(response).to redirect_to orders_path
      end

      it 'shows error message' do
        post :create, group_order: group_order_params
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end