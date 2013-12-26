require 'spec_helper'

describe OrdersController do

  describe 'GET#new' do

    it 'assigns @order' do
      order = Order.new
      Order.stub(:new).and_return(order)
      get :new

      expect(assigns(:order)).to eq(order)
    end
  end

  describe 'POST#create' do
    let(:order_params) {
      {
        item_attributes: { name: "Item", price: 6.95 },
        customer_attributes: { name: "Customer" }
      }
    }

    it 'creates a new order' do
      expect{
        post :create, order: order_params
      }.to change(Order, :count).by(1)
    end

    it 'redirects to order list' do
      post :create, order: order_params
      expect(response).to redirect_to orders_path
    end
  end

  describe 'GET#index' do
    let!(:order) { FactoryGirl.create(:order) }

    it 'assigns @orders with all orders' do
      get :index
      expect(assigns(:orders)).to eq([order])
    end

    it 'eager loads item and customer' do
      Order.stub(:all).and_return(Order)
      expect(Order).to receive(:includes).with(:item, :customer).and_return([])
      get :index
    end

    it 'assigns @group_order' do
      get :index
      expect(assigns(:group_order).orders).to eq([order])
    end
  end
end