# frozen_string_literal: true

# Creates InvalidAccountError class
class InvalidAccountError < Errors::UnprocessableEntityError
  attr_reader :account

  # Implements initialize method
  #
  # @param account [Account]
  def initialize(account:)
    @account = account
  end

  # Describes error_code
  #
  # @return [Symbol]
  def error_code
    :invalid_account
  end

  # Describes error message
  #
  # @return [String]
  def message
    "Account with #{account.iban} iban does not exist."
  end
end
