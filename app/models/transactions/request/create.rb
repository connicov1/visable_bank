# frozen_string_literal: true

# Opens Transactions namespace
module Transactions
  # Opens Request namespace
  module Request
    # Creates Create model class
    class Create < ApplicationModel
      attribute :account_from_iban, :string
      attribute :account_to_iban, :string
      attribute :amount, :decimal
      attribute :currency, :string
      attribute :description, :string

      # Defines ATTRIBUTES constant
      ATTRIBUTES = %w[
        account_from_iban
        account_to_iban
        amount
        currency
        description
      ].freeze

      validates(*ATTRIBUTES, presence: true)
      validates_numericality_of :amount, :greater_than => 0.0

      include CurrencyValidations
    end
  end
end
