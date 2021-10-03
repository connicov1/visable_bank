# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:account_from) { create(:account, iban: 'TEST010101', balance: 100000) }
  let(:account_to) { create(:account, iban: 'TEST020202') }
  let(:account_id) { account_from.id }
  let(:receiver_account_id) { account_to.id}
  let(:amount) { '1234.33' }
  let(:currency) { 'EUR' }
  let(:description) { 'simple description' }
  let(:date) { Time.zone.now.to_date.to_s }
  let(:status) { 'pending' }
  let(:transaction_type) { 'payment' }

  let(:params) do
    {
      account_id: account_id,
      receiver_account_id: receiver_account_id,
      amount: amount,
      currency: currency,
      description: description,
      date: date,
      status: status,
      transaction_type: transaction_type
    }
  end

  let(:transaction) { described_class.new(params) }

  describe '#initialize' do
    it 'sets all the Transaction attributes correctly' do
      Transaction::ATTRIBUTES.each do |attribute|
        expect(transaction.send(attribute)).to eq(params[attribute.to_sym])
      end
    end
  end

  describe '#validate' do
    it 'does not add any error' do
      transaction.validate
      expect(transaction.errors).to be_empty
    end

    it 'adds format error for invalid amount' do
      params[:amount] = 0
      transaction.validate
      expect(transaction.errors.messages[:amount].first).to eq('must be greater than 0.0')
    end

    context 'when buy_currency length is different than 3' do
      it 'adds length validation error' do
        params[:currency] = 'EUR11'
        transaction.validate
        expect(transaction.errors.full_messages.first).to eq(
          'Currency must be a valid ISO 4217 Three-digit currency code'
        )
      end
    end
  end

  describe '#process!' do
    context 'when transaction status is pending' do
      before do
        transaction.update(status: 'pending')
        transaction.process!
      end

      it 'changes transaction status to processing' do
        expect(transaction.status).to eq('processing')
      end
    end
  end

  describe '#fail!' do
    context 'when transaction status is processing' do
      before do
        transaction.update!(status: 'processing')
        transaction.fail!
      end

      it 'changes transaction status to failed' do
        expect(transaction.status).to eq('failed')
      end
    end
  end

  describe '#complete!' do
    context 'when transaction status is processing' do
      before do
        transaction.update!(status: 'processing')
        transaction.complete!
      end

      it 'changes transaction status to completed' do
        expect(transaction.status).to eq('completed')
      end
    end

    context 'when transaction status is failed' do
      before do
        transaction.update!(status: 'failed')
        transaction.complete!
      end

      it 'changes transaction status to completed' do
        expect(transaction.status).to eq('completed')
      end
    end
  end
end
