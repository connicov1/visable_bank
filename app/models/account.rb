# frozen_string_literal: true

# Defines Account model class
class Account < ApplicationRecord
  # attribute @name [String]
  # attribute @iban [String]
  # attribute @currency [String]
  # attribute @nature [String]
  # attribute @status [String]
  # attribute @balance [String]

  has_many :transactions

  # Defines ATTRIBUTES constant
  ATTRIBUTES = %w[
    name
    iban
    currency
    nature
    status
    balance
  ].freeze

  # Defines ACCOUNT_NATURES constant
  ACCOUNT_NATURES = %w[account credit_card debit_card loan].freeze

  ACCOUNT_NATURES.each do |account_nature|
    define_method("#{account_nature}?") do
      nature == account_nature
    end
  end

  validates(*ATTRIBUTES, presence: true)
  validates :iban, uniqueness: true
  validates :nature,
            inclusion: {
              in: ACCOUNT_NATURES,
              message: "Nature '%<value>s' is invalid, available options are: #{ACCOUNT_NATURES}".tr('\"', "'")
            }, allow_blank: true

  include CurrencyValidations

  # Defines serializer class
  #
  # @return [AccountSerializer]
  def serializer_class
    AccountSerializer
  end

  # Updates balance of account
  #
  # @return [Boolean]
  def update_balance!(side:, amount:)
    updated_balance = balance.public_send(side, amount)

    update!(balance: updated_balance)
  end
end
