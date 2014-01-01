require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }
  subject { user }

  describe 'validations' do

    it { should be_valid }

    context 'without a balance' do
      before { user.balance = "" }

      it { should_not be_valid }
    end

    context 'with no numerical balance' do
      before { user.balance = "text" }

      it { should_not be_valid }
    end

    context 'with a balance of 999999.001' do
      before { user.balance = 999999.001 }

      it { should_not be_valid }
    end

    context 'with a balance of 999999' do
      before { user.balance = 999999 }

      it { should be_valid }
    end

    context 'with a balance of -999999.001' do
      before { user.balance = -999999.001 }

      it { should_not be_valid }
    end

    context 'with a balance of -999999' do
      before { user.balance = -999999 }

      it { should be_valid }
    end
  end

  describe 'initial balance' do

    context 'when not specified' do

      it 'sets to 0.0' do
        user.save
        expect(user.reload.balance).to eq(0.0)
      end
    end

    context 'when specified' do
      before { user.balance = 6.75 }

      it 'does not set to default' do
        user.save
        expect(user.reload.balance).to eq(6.75)
      end
    end

    context 'when precision is more than 2' do
      before { user.balance = 6.666 }

      it 'rounds to 2' do
        user.save
        expect(user.reload.balance).to eq(6.67)
      end
    end
  end

  describe '#add_balance' do

    context 'possitive amount' do
      before do
        user.balance = 6.95
        user.add_balance(7.25)
      end

      its(:balance) { should eq(14.2) }
    end

    context 'negative amount' do
      before do
        user.balance = 6.95
        user.add_balance(-7.25)
      end

      its(:balance) { should eq(-0.3) }
    end

    context 'not valid' do
      before { user.balance = 6.95 }

      it 'throws exception' do
        expect { user.add_balance(999999) }.to raise_error
      end
    end
  end
end
