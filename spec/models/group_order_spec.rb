require 'spec_helper'

describe GroupOrder do

  describe '.create' do
    let(:order1) { FactoryGirl.create(:order) }
    let(:order2) { FactoryGirl.create(:order) }
    let(:group_order_params) {
      {
        total: 20,
        order_ids: [order1.id, order2.id]
      }
    }

    it 'creates a new group order' do
      expect {
        GroupOrder.create(group_order_params)
      }.to change(GroupOrder, :count).by(1)
    end

    describe 'new created group order' do
      let(:new_group_order) { GroupOrder.create(group_order_params) }
      subject { new_group_order }

      its(:total) { should eq(20.0) }
      its(:orders) { should =~ [order1, order2]}
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
