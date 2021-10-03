# frozen_string_literal: true

# Defines Transaction model class
class Transaction < ApplicationRecord
  # attribute @description [String]
  # attribute @amount [BigDecimal]
  # attribute @type [String]
  # attribute @currency [String]
  # attribute @status [String]
  # attribute @date [String] - in %Y-%m-%d format
  # attribute @account_id [String]

  include AASM

  belongs_to :account

  # TODO: add cancelled status
  aasm column: :status do
    state :pending, initial: true
    state :processing, :completed, :failed

    event :process do
      transitions from: :pending, to: :processing
    end

    event :complete do
      transitions from: :processing, to: :completed
      transitions from: :failed, to: :completed
    end

    event :fail do
      transitions from: :processing, to: :failed
    end
  end

  # Defines ATTRIBUTES constant
  ATTRIBUTES = %w[
    description
    amount
    transaction_type
    currency
    status
    date
    account_id
    receiver_account_id
  ].freeze

  validates(*ATTRIBUTES, presence: true)
  validates_numericality_of :amount, :greater_than => 0.0

  include DateValidations
  include CurrencyValidations

  # Defines serializer class
  #
  # @return [TransactionSerializer]
  def serializer_class
    TransactionSerializer
  end
end
