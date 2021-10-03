# frozen_string_literal: true

# Opens Accounts namespace
module Accounts
  # Creates TransactionsService class
  class TransactionsService
    attr_reader :params

    # Defines #initialize method
    #
    # @param params [Hash]
    def initialize(params:)
      @params = params
    end

    # Validates account presence and returns a Hash with account balance
    # and its transactions list
    #
    # @return [Hash]
    def execute!
      validate_request!

      build_response!
    end

    private

    # Validates account presence
    #
    # @raise [ActiveRecord::NotFound]
    # @return [Account]
    def validate_request!
      account_model!
    end

    # Builds a serialized Hash with account balance and transactions list
    #
    # @raise [ActiveRecord::NotFound]
    # @return [Hash]
    def build_response!
      Accounts::TransactionsSerializer.new(account_model!, scope: transactions_count)
    end

    # @raise [ActiveRecord::NotFound]
    # @return [Account]
    def account_model!
      @account_model ||= Account.find_by!(id: params[:account_id])
    end

    # @return [String] - requested amount of transactions
    def transactions_count
      @transactions_count ||= params[:count]
    end
  end
end
