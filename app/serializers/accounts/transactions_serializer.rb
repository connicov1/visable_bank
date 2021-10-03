# frozen_string_literal: true

# Opens Accounts namespace
module Accounts
  # Creates TransactionsSerializer class
  class TransactionsSerializer < ApplicationSerializer
    attribute :balance
    attribute :transactions

    # @return [Array<Transaction>]
    def transactions
      return object.transactions if transaction_count.blank?

      object.transactions.last(transaction_count.to_i)
    end

    private

    # @return [String, NilClass]
    def transaction_count
      instance_options[:scope] || object.scope
    end
  end
end
