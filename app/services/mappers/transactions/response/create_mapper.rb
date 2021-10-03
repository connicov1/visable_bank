# frozen_string_literal: true

module Mappers
  # Opens Transactions namespace
  module Transactions
    # Opens Response namespace
    module Response
      # Creates CreateMapper class
      class CreateMapper
        attr_reader :transaction_model, :account_from, :account_to

        # Defines #initialize method
        #
        # @param transaction_model [Transaction]
        # @param account_from [Account]
        # @param account_to [Account]
        def initialize(transaction_model:, account_from:, account_to:)
          @transaction_model = transaction_model
          @account_from = account_from
          @account_to = account_to
        end

        # Builds a mapped Hash to create a new Transaction record
        #
        # @return Hash
        def execute
          {
            description: transaction_model.description,
            amount: transaction_model.amount,
            transaction_type: transaction_type,
            currency: transaction_model.currency,
            date: Time.zone.now.to_date.to_s,
            account_id: account_from.id,
            receiver_account_id: account_to.id
          }
        end

        private

        # Finds and returns a corresponding transaction type
        #
        # TODO: extract this logic into a separate helper
        #
        # @return [String]
        def transaction_type
          case transaction_model.description
          when /payment/i
            'payment'
          when /salary/i
            'salary'
          else
            'transfer'
          end
        end
      end
    end
  end
end
