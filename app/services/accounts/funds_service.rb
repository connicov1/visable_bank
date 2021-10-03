# frozen_string_literal: true

# Opens Accounts namespace
module Accounts
  # Creates FundsService class that uses PFAAO pattern
  class FundsService
    # Defines #call! method
    #
    # @raise [ActiveRecord::RecordInvalid]
    # @return [Boolean]
    def self.call!(account_from:, account_to:, amount:)
      new(account_from, account_to, amount).call!
    end

    attr_reader :account_from, :account_to, :amount

    # Defines #initialize method
    #
    # @param account_from [Account]
    # @param account_to [Account]
    # @param amount [BigDecimal]
    def initialize(account_from, account_to, amount)
      @account_from = account_from
      @account_to = account_to
      @amount = amount
    end
    private_class_method :new

    # Adds funds for the receiver account and substracts funds from the sender account
    #
    # @raise [ActiveRecord::RecordInvalid]
    # @return [Boolean]
    def call!
      account_from.update_balance!(side: :-, amount: amount)
      account_to.update_balance!(side: :+, amount: amount)
    end
  end
end
