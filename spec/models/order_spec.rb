require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.create :order }
  subject { order }

  describe 'validations' do

    it { should be_valid }

    context 'without an item' do
      before { order.item = nil }

      it { should_not be_valid }
    end

    context 'without an customer' do
      before { order.customer = nil }

      it { should_not be_valid }
    end

    context 'customer is not valid' do
      before { order.customer.name = "" }

      it { should_not be_valid }
    end

    context 'item is not valid' do
      before { order.item.name = "" }

      it { should_not be_valid }
    end
  end
end
