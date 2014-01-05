require 'spec_helper'

describe BalanceHelper do

  describe '#balance_span' do

    context 'balance is negtive' do
      let(:balance) { -7.5 }

      it 'returns span.neg-balance' do
        expect(balance_span(balance)).to eq("<span class='neg-balance'>7.5</span>")
      end
    end

    context 'balance is possitive' do
      let(:balance) { 7.5 }

      it 'returns span.non-neg-balance' do
        expect(balance_span(balance)).to eq("<span class='non-neg-balance'>7.5</span>")
      end
    end

    context 'balance is 0.0' do
      let(:balance) { 0.0 }

      it 'returns span.non-neg-balance' do
        expect(balance_span(balance)).to eq("<span class='non-neg-balance'>0.0</span>")
      end
    end
  end
end