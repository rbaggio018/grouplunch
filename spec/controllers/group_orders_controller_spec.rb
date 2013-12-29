require 'spec_helper'

describe GroupOrdersController do
  let(:current_user) { FactoryGirl.create(:user) }
  before { sign_in current_user }

  describe 'POST#create' do
    let(:order1) { FactoryGirl.create(:order) }
    let(:order2) { FactoryGirl.create(:order) }

    let(:group_order_params) {
      {
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

    it 'associates group order and current user' do
      post :create, group_order: group_order_params
      expect(GroupOrder.last.customer).to eq(current_user)
    end

    it 'updates balances' do
      expect(BalanceCalculator).to receive(:calculate).once
      post :create, group_order: group_order_params
    end

    context 'not valid' do
      before { group_order_params[:total] = "" }

      it 'does not create group order' do
        expect {
          post :create, group_order: group_order_params
        }.to change(GroupOrder, :count).by(0)
      end

      it 'renders orders/index' do
        post :create, group_order: group_order_params
        expect(response).to render_template("orders/index")
      end

      it 'assigns @orders' do
        post :create, group_order: group_order_params
        expect(assigns(:orders)).to match_array([order1, order2])
      end

      it 'shows error message' do
        post :create, group_order: group_order_params
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end