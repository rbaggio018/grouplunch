require 'spec_helper'

describe BalanceCalculator do

  describe '.calculate' do
    [
      %w( 5.0   10.0  20.0  0.0   0.0   0.0   35.0  -5.0   -10.0   15.0   simple_case),
      %w( 5.0   10.0  20.0  0.0   0.0   0.0   28.0  -4.0   -8.0    12.0   discount_applied),
      %w( 5.0   10.0  20.0  0.0   0.0   0.0   42.0  -6.0   -12.0   18.0   tax_applied),
      %w( 5.0   10.0  20.0  1.25  -2.25 3.25  42.0  -4.75  -14.25  21.25  with_init_balance),
      %w( 8.95  7.25  6.25  0.0   0.0   0.0   24.03 -9.58  -7.76   17.34  round_needed)
    ].each do |user1_orded, user2_ordered, user3_ordered,
                user1_init_balance, user2_init_balance, user3_init_balance,
                user3_payed,
                user1_expected, user2_expected, user3_expected,
                scenario|

      describe "scenario #{scenario}" do
        let(:item1) { FactoryGirl.create(:item, price: user1_orded) }
        let(:item2) { FactoryGirl.create(:item, price: user2_ordered) }
        let(:item3) { FactoryGirl.create(:item, price: user3_ordered) }

        let(:user1) { FactoryGirl.create(:user, balance: user1_init_balance) }
        let(:user2) { FactoryGirl.create(:user, balance: user2_init_balance) }
        let(:user3) { FactoryGirl.create(:user, balance: user3_init_balance) }

        let(:order1) { FactoryGirl.create(:order, customer: user1, item: item1) }
        let(:order2) { FactoryGirl.create(:order, customer: user2, item: item2) }
        let(:order3) { FactoryGirl.create(:order, customer: user3, item: item3) }

        let(:group_order) { FactoryGirl.create(:group_order, orders: [order1, order2, order3], total: user3_payed, customer: user3) }

        before { BalanceCalculator.calculate(group_order) }

        it 'updates balances of customers properly' do
          expect(user1.balance).to eq(user1_expected.to_d)
          expect(user2.balance).to eq(user2_expected.to_d)
          expect(user3.balance).to eq(user3_expected.to_d)
        end
      end
    end
  end
end