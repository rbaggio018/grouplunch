require 'spec_helper'

describe GroupOrder do
  let(:group_order) { FactoryGirl.create :group_order }
  subject { group_order }

  describe 'validations' do

    it { should be_valid }

    context 'without a customer' do
      before { group_order.customer = nil }

      it { should_not be_valid }
    end

    context 'without an order' do
      before { group_order.orders = [] }

      it { should_not be_valid }
    end

    context 'without a total' do
      before { group_order.total = "" }

      it { should_not be_valid }
    end

    context 'with no numerical total' do
      before { group_order.total = "text" }

      it { should_not be_valid }
    end

    context 'with a total which precision more than 2' do
      before { group_order.total = 0.009 }

      it { should_not be_valid }
    end

    context 'with a negative total' do
      before { group_order.total = -0.1 }

      it { should_not be_valid }
    end

    context 'with a total of 10000.01' do
      before { group_order.total = 10000.01 }

      it { should_not be_valid }
    end

    context 'with a total of 10000' do
      before { group_order.total = 10000 }

      it { should be_valid }
    end

    context 'customer is not valid' do
      before { group_order.customer.name = "" }

      it { should_not be_valid }
    end
  end

  describe '#sum' do
    let(:order1) { FactoryGirl.create(:order, item: FactoryGirl.create(:item, price: 6.50)) }
    let(:order2) { FactoryGirl.create(:order, item: FactoryGirl.create(:item, price: 7.25)) }
    let(:group_order) { FactoryGirl.create(:group_order, orders: [order1, order2]) }

    it 'returns the sum of orders price' do
      expect(group_order.sum).to eq(13.75)
    end
  end
end
