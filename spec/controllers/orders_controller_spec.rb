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
        item: { name: "Item", price: 6.95, specs: "Specs" },
        customer: { name: "Customer" }
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

    it 'shows notice' do
      post :create, order: order_params
      expect(flash[:notice]).not_to be_nil
    end

    context 'new customer' do

      it 'creates a new user' do
        expect{
          post :create, order: order_params
        }.to change(User, :count).by(1)
      end

      it 'associates order with new user' do
        post :create, order: order_params
        expect(Order.last.customer).to eq(User.last)
      end
    end

    context 'return customer' do
      let!(:existing_user) { FactoryGirl.create(:user, name: "Customer") }

      it 'does not create user' do
        expect{
          post :create, order: order_params
        }.to change(User, :count).by(0)
      end

      it 'associates order with the existing user' do
        post :create, order: order_params
        expect(Order.last.customer).to eq(existing_user)
      end
    end

    context 'new item' do

      it 'creates a new item' do
        expect{
          post :create, order: order_params
        }.to change(Item, :count).by(1)
      end

      it 'associates order with new item' do
        post :create, order: order_params
        expect(Order.last.item).to eq(Item.last)
      end
    end

    context 'existing item' do
      let!(:existing_item) { FactoryGirl.create(:item, name: "Item", price: 6.95, specs: "Specs") }

      it 'does not create item' do
        expect{
          post :create, order: order_params
        }.to change(Item, :count).by(0)
      end

      it 'associates order with existing item' do
        post :create, order: order_params
        expect(Order.last.item).to eq(existing_item)
      end
    end

    context 'new item with same name and same specs but different price' do
      let!(:item) { FactoryGirl.create(:item, name: "Item", price: 7.25, specs: "Specs") }

      it 'creates a new item' do
        expect{
          post :create, order: order_params
        }.to change(Item, :count).by(1)
      end

      it 'associates order with new item' do
        post :create, order: order_params
        expect(Order.last.item).to eq(Item.last)
      end
    end

    context 'new item with same name and same price but different specs' do
      let!(:item) { FactoryGirl.create(:item, name: "Item", price: 6.95, specs: "Different Specs") }

      it 'creates a new item' do
        expect{
          post :create, order: order_params
        }.to change(Item, :count).by(1)
      end

      it 'associates order with new item' do
        post :create, order: order_params
        expect(Order.last.item).to eq(Item.last)
      end
    end

    context 'not valid' do
      before { order_params[:customer][:name] = "" }

      it 'does not create a new order' do
        expect{
          post :create, order: order_params
        }.to change(Order, :count).by(0)
      end

      it 'renders new template' do
        post :create, order: order_params
        expect(response).to render_template(:new)
      end

      it 'shows error message' do
        post :create, order: order_params
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'GET#index' do
    let!(:order) { FactoryGirl.create(:order) }

    it 'assigns @orders with all orders' do
      get :index
      expect(assigns(:orders)).to eq([order])
    end

    context 'group order has placed' do
      let!(:new_order) { FactoryGirl.create(:order) }
      before { FactoryGirl.create(:group_order, orders: [order]) }

      it 'assigns @orders with non gorup placed orders' do
        get :index
        expect(assigns(:orders)).to eq([new_order])
      end
    end

    it 'eager loads item and customer' do
      Order.stub(:where).and_return(Order)
      expect(Order).to receive(:includes).with(:item, :customer).and_return([])
      get :index
    end

    it 'assigns @group_order' do
      get :index
      expect(assigns(:group_order).orders).to eq([order])
    end
  end
end