require 'spec_helper'

describe Order do

  describe 'nested attributes' do
    let(:order_params) {
      {
        item_attributes: { name: "Item", price: 6.95 },
        customer_attributes: { name: "Customer" }
      }
    }

    describe '.create' do

      it 'creates a new item' do
        expect { Order.create(order_params) }.to change(Item, :count).by(1)
      end

      it 'creates a new user' do
        expect { Order.create(order_params) }.to change(User, :count).by(1)
      end

      it 'creates a new order' do
        expect { Order.create(order_params) }.to change(Order, :count).by(1)
      end

      describe 'new created order' do
        let(:new_order) { Order.create(order_params) }
        subject { new_order }

        its(:item) { should_not be_nil }
        its(:customer) { should_not be_nil }
      end
    end
  end
end
