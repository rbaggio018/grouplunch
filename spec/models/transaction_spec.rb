require 'spec_helper'

describe Transaction do

  describe '.create' do
    let(:source) { FactoryGirl.create(:user, balance: -6.95) }
    let(:destination) { FactoryGirl.create(:user, balance: 8.5) }

    before do
      Transaction.create({
        source: source,
        destination: destination,
        amount: 7
      })
    end

    it 'updates source balance' do
      expect(source.reload.balance).to eq(0.05)
    end

    it 'updates destination balance' do
      expect(destination.reload.balance).to eq(1.5)
    end
  end
end
