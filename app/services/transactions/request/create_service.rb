# frozen_string_literal: true

# Opens Transactions namespace
module Transactions
  # Opens Request namespace
  module Request
    # Creates CreateService class
    class CreateService
      attr_reader :params

      # Defines #initialize method
      #
      # @param params [Hash]
      def initialize(params)
        @params = params
      end

      # Validates and creates a new transaction record
      #
      # @return [Hash]
      def execute!
        validate_request!
        perform_request!

        build_response
      end

      private

      # Validates for account presence, create model validations
      # and if respective account has enough funds
      #
      # @raise [ActiveRecord::RecordInvalid]
      # @return [NilClass, Boolean]
      def validate_request!
        validate_accounts_presence!
        validate_account_funds!

        transaction_create_model.validate!
      end

      # Validates transaction model and updates the accounts balances
      #
      # @raise [ActiveRecord::RecordInvalid, StandardError]
      # @return [NilClass, Boolean]
      def perform_request!
        transaction_model.validate!
        transaction_model.save!
        transaction_model.process!

        ActiveRecord::Base.transaction do
          handle_account_amounts!

          transaction_model.complete!
        end
      rescue StandardError => e
        transaction_model.fail!
        raise e
      end

      # Returns a REST response hash
      #
      # @retrun [Hash]
      def build_response
        { status: :success, data: {} }
      end

      # Mapps request params to create a transaction
      #
      # @return [Hash]
      def transaction_mapped_params
        transaction_mapper.new(
          transaction_model: transaction_create_model,
          account_from: account_from,
          account_to: account_to
        ).execute
      end

      # Updates balances for sender account and receiver account
      #
      # @raise [ActiveRecord::RecordInvalid]
      # @return [Boolean]
      def handle_account_amounts!
        Accounts::FundsService.call!(
          account_from: account_from,
          account_to: account_to,
          amount: amount
        )
      end

      # @return [Transactions::Request::Create]
      def transaction_create_model
        @transaction_create_model ||= Transactions::Request::Create.new(params)
      end

      # @return [Transaction]
      def transaction_model
        @transaction_model ||= Transaction.new(transaction_mapped_params)
      end

      # @return [Mappers::Transactions::Response::CreateMapper]
      def transaction_mapper
        ::Mappers::Transactions::Response::CreateMapper
      end

      # Checks if account has enough funds to perform transaction
      #
      # @raise [InsufficientFundsError]
      # @return [NilClass]
      def validate_account_funds!
        Accounts::FundsValidatorService.call!(account_from: account_from, amount: amount)
      end

      # Validates accounts for presence
      #
      # TODO: extract this logic into a separate validator class
      #
      # @return [NilClass]
      # @raise [InvalidAccountError]
      def validate_accounts_presence!
        return if account_from.present? && account_to.present?

        raise InvalidAccountError.new(account: account_from || account_to)
      end

      # @return [Account, NilClass]
      def account_from
        @account_from ||= Account.find_by(iban: params[:account_from_iban])
      end

      # @return [Account, NilClass]
      def account_to
        @account_to ||= Account.find_by(iban: params[:account_to_iban])
      end

      # @return [BigDecimal]
      def amount
        @amount ||= transaction_create_model.amount
      end
    end
  end
end
