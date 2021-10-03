# frozen_string_literal: true

# Class defining custom date format validation
# Example usage:
#   validates :attribute_name, date_format: true
class DateFormatValidator < ActiveModel::EachValidator
  # Defines regex date format for iso8601.
  DATE_FORMAT = /^(\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))$/.freeze

  # Overrides validate_each method
  def validate_each(record, attribute, value)
    return if value =~ DATE_FORMAT

    record.errors.add(attribute, :invalid, message: 'must conform to ISO8601 (YYYY-MM-DD) format')
  end
end
