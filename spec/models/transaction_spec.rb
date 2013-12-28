require 'spec_helper'

describe Transaction do
  let(:transaction) { FactoryGirl.build :transaction }
  subject { transaction }

  it { should be_valid }

  describe 'validations' do

    context 'without a source' do
      before { transaction.source = nil }

      it { should_not be_valid }
    end

    context 'without a destination' do
      before { transaction.destination = nil }

      it { should_not be_valid }
    end

    context 'without an amount' do
      before { transaction.amount = "" }

      it { should_not be_valid }
    end

    context 'with no numerical amount' do
      before { transaction.amount = "text" }

      it { should_not be_valid }
    end

    context 'with an amount which precision more than 2' do
      before { transaction.amount = 0.009 }

      it { should_not be_valid }
    end

    context 'with a negative amount' do
      before { transaction.amount = -0.1 }

      it { should_not be_valid }
    end

    context 'with a zero amount' do
      before { transaction.amount = 0.0 }

      it { should_not be_valid }
    end

    context 'with an amount of 100000.01' do
      before { transaction.amount = 100000.01 }

      it { should_not be_valid }
    end

    context 'with an amount of 100000' do
      before { transaction.amount = 100000 }

      it { should be_valid }
    end
  end

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
