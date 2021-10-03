# frozen_string_literal: true

# Opens Errors namespace
module Errors
  # Class defining api result responses for errors following REST standards
  class BadRequestException < StandardError
    include ActiveModel::Serialization

    # Defines ATTRIBUTES constant
    ATTRIBUTES = %i[
      http_status
      error_reason
    ].freeze

    attr_reader(*ATTRIBUTES)

    # @param http_status [Symbol]
    # @param error_reason [String]
    def initialize(http_status:, error_reason:)
      @http_status = http_status
      @error_reason = error_reason
    end

    # @return [Hash] attribute keys and values
    def attributes
      ATTRIBUTES.each_with_object({}) do |attr, hash|
        hash[attr] = public_send(attr)
      end
    end
  end
end
