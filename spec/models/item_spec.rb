require 'spec_helper'

describe Item do
  let(:item) { FactoryGirl.create :item }
  subject { item }

  describe 'validations' do

    it { should be_valid }

    context 'without a name' do
      before { item.name = "" }

      it { should_not be_valid }
    end

    context 'without a price' do
      before { item.price = "" }

      it { should_not be_valid }
    end

    context 'with no numerical price' do
      before { item.price = "text" }

      it { should_not be_valid }
    end

    context 'with a price which precision more than 2' do
      before { item.price = 0.009 }

      it { should_not be_valid }
    end

    context 'with a negative price' do
      before { item.price = -0.1 }

      it { should_not be_valid }
    end

    context 'with a price of 100.01' do
      before { item.price = 100.01 }

      it { should_not be_valid }
    end

    context 'with a price of 100' do
      before { item.price = 100 }

      it { should be_valid }
    end
  end
end
