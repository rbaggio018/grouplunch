require 'spec_helper'

describe OrdersController do
  let(:current_user) { FactoryGirl.create(:user) }
  before { sign_in current_user }

  describe 'GET#new' do

    context 'current_user has not ordered yet' do
      before { get :new }

      it 'assigns @order with new order' do
        expect(assigns(:order)).to be_new_record
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'current_user has ordered' do
      let!(:order) { FactoryGirl.create(:order, customer: current_user) }

      context 'group order has not been placed yet' do
        before { get :new }

        it 'assigns @order with order of current user' do
          expect(assigns(:order)).to eq(order)
        end

        it 'renders show template' do
          expect(response).to render_template(:show)
        end
      end

      context 'group order has been placed' do
        before do
          FactoryGirl.create(:group_order, orders: [order])
          get :new
        end

        it 'assigns @order with new order' do
          expect(assigns(:order)).to be_new_record
        end

        it 'renders new template' do
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'POST#create' do
    let(:order_params) {
      {
        item: { name: "Item", price: 6.95, specs: "Specs" }
      }
    }

    it 'creates a new order' do
      expect{
        post :create, order: order_params
      }.to change(Order, :count).by(1)
    end

    context 'successfully created' do
      before { post :create, order: order_params }

      it 'redirects to home page' do
        expect(response).to redirect_to root_url
      end

      it 'shows notice' do
        expect(flash[:notice]).not_to be_nil
      end

      it 'associates order with current user' do
        expect(Order.last.customer).to eq(current_user)
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
      before { order_params[:item][:name] = "" }

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

    context 'group order has been placed' do
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

  describe 'GET#edit' do
    let!(:order) { FactoryGirl.create(:order) }

    context 'group order has not been placed' do
      before { get :edit, id: order.id }

      it 'assigns @order' do
        expect(assigns(:order)).to eq(order)
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'group order has been placed' do
      before do
        FactoryGirl.create(:group_order, orders: [order])
        get :edit, id: order.id
      end

      it 'assigns @order' do
        expect(assigns(:order)).to eq(order)
      end

      it 'redirects to group order page' do
        expect(response).to redirect_to(order.group_order)
      end

      it 'shows error message' do
        expect(flash[:error]).not_to be_nil
      end
    end
  end

  describe 'PUT#update' do
    let!(:order) { FactoryGirl.create(:order) }
    let(:order_params) {
      {
        item: { name: "Item", price: 6.95, specs: "Specs" }
      }
    }

    context 'successfully updated' do
      before { put :update, id: order.id, order: order_params }

      it 'updates the order' do
        expect(order.reload.item.specs).to eq("Specs")
      end

      it 'assigns @order' do
        expect(assigns(:order)).to eq(order)
      end

      it 'renders show template' do
        expect(response).to render_template(:show)
      end

      it 'shows notice' do
        expect(flash[:notice]).not_to be_nil
      end
    end

    context 'group order has been placed' do
      before do
        FactoryGirl.create(:group_order, orders: [order])
        put :update, id: order.id, order: order_params
      end

      it 'redirects to group order page' do
        expect(response).to redirect_to(order.reload.group_order)
      end

      it 'shows error message' do
        expect(flash[:error]).not_to be_nil
      end
    end

    context 'not valid' do
      before do
        order_params[:item][:name] = ""
        put :update, id: order.id, order: order_params
      end

      it 'does not update the order' do
        expect(order.reload.item.specs).not_to eq("Specs")
      end

      it 'assigns @order' do
        expect(assigns(:order)).to eq(order)
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end

      it 'shows error message' do
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end