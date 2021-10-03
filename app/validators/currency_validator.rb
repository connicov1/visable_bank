# frozen_string_literal: true

# Class for currency validation
# Example usage:
#   validates :attribute_name, currency: true
class CurrencyValidator < ActiveModel::EachValidator
  # Regex for currency
  CURRENCY_REGEX = /\A[A-Z]+\z/.freeze

  # Custom validator for currency
  def validate_each(record, attribute, value)
    return if value.is_a?(String) && value.length == 3 && value =~ CURRENCY_REGEX

    record.errors.add(attribute, :invalid, message: 'must be a valid ISO 4217 Three-digit currency code')
  end
end
