# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions requests', type: :request do
  let(:account_from) { create(:account, iban: 'TEST010101', balance: 100000) }
  let(:account_to) { create(:account, iban: 'TEST020202') }

  let(:create_params) do
    {
      account_from_iban: account_from.iban,
      account_to_iban: account_to.iban,
      amount: 100,
      currency: 'EUR',
      description: 'Test description'
    }
  end

  let(:expected_transaction_response) do
    { status: 'success', data: {} }.stringify_keys
  end

  describe '/v1/transactions' do
    before do
      post v1_transactions_path, params: create_params
    end

    context 'when valid params' do
      it 'returns successful response' do
        expect(response).to be_successful
      end

      it 'returns expected transaction response' do
        expect(JSON.parse(response.body)).to eq(expected_transaction_response)
      end
    end
  end
end
