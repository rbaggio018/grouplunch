require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }
  subject { user }

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
  end
end
