# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Accounts requests', type: :request do
  let(:account) { create(:account, :with_transactions) }

  let(:create_params) do
    {
      name: 'Test Account',
      iban: 'TESTIBAN123123',
      currency: 'EUR',
      nature: 'account'
    }
  end

  let(:get_transactions_params) do
    { count: 10 }
  end

  let(:expected_create_response) do
    {
      status: 'success',
      data: {
        id: '123',
        name: 'Test Account',
        iban: 'TESTIBAN123123',
        currency: 'EUR',
        nature: 'account',
        status: 'active',
        balance: 0
      }.stringify_keys
    }.stringify_keys
  end

  let(:expected_transactions_response) do
    {
      status: 'success',
      data: {
        balance: account.balance,
        transactions: account.transactions.to_a.map(&:as_json)
      }.stringify_keys
    }.stringify_keys
  end

  describe '/v1/accounts' do
    context 'when valid params' do
      before do
        allow(SecureRandom).to receive(:uuid).and_return('123')

        post v1_accounts_path, params: create_params
      end

      it 'returns successful response' do
        expect(response).to be_successful
      end

      it 'returns expected account response' do
        expect(JSON.parse(response.body)).to eq(expected_create_response)
      end
    end
  end

  describe '/v1/accounts/:account_id/transactions' do
    context 'when valid params' do
      before do
        get v1_account_transactions_path(account_id: account.id), params: get_transactions_params
      end

      it 'returns successful response' do
        expect(response).to be_successful
      end

      it 'returns expected account transactions response' do
        expect(JSON.parse(response.body)).to eq(expected_transactions_response)
      end
    end
  end
end
