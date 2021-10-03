# frozen_string_literal: true

# Creates InsufficientFundsError class
class InsufficientFundsError < Errors::UnprocessableEntityError
  # Implements initialize method
  #
  # @param account [Account]
  def initialize(account)
    @account = account
  end

  # Describes error_code
  #
  # @return [Symbol]
  def error_code
    :insufficient_funds
  end

  # Describes error message
  #
  # @return [String]
  def message
    "Insufficient funds."
  end
end
