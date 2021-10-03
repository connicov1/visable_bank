# frozen_string_literal: true

# Opens Accounts namespace
module Accounts
  # Creates FundsValidatorService class that uses PFAAO pattern
  class FundsValidatorService
    # Defines #call! method
    #
    # @raise [InsufficientFundsError]
    # @return [NilClass]
    def self.call!(account_from:, amount:)
      new(account_from, amount).call!
    end

    attr_reader :account_from, :amount

    # Defines #initialize method
    #
    # @param account_from [Account]
    # @param amount [BigDecimal]
    def initialize(account_from, amount)
      @account_from = account_from
      @amount = amount
    end
    private_class_method :new

    # Validates if account has enough funds to perform a transaction
    #
    # NOTE: credit cards are able to have negative balance
    #
    # @raise [InsufficientFundsError]
    # @return [NilClass]
    def call!
      return if account_from.balance >= amount.to_d || account_from.credit_card?

      raise InsufficientFundsError.new(account: account_from)
    end
  end
end
