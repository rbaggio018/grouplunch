require 'spec_helper'

describe OrdersController do

  describe 'GET#new' do

    it 'asigns @order' do
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

    it 'asigns @orders with all orders' do
      order = FactoryGirl.create(:order)
      get :index

      expect(assigns(:orders)).to eq([order])
    end
  end
end