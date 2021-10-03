# frozen_string_literal: true

# Opens Errors namespace
module Errors
  # Class defining api result responses for errors following RESTful standards
  class ActiveRecordApiException < StandardError
    include ActiveModel::Serialization

    # Defines ATTRIBUTES constant
    ATTRIBUTES = %i[
      http_status
      status
      error_code
      error_reason
    ].freeze

    attr_reader(*ATTRIBUTES)

    # @param http_status [Symbol]
    # @param error_code [Symbol]
    # @param error_reason [String]
    # @param options [Hash]
    def initialize(http_status:, error_code:, error_reason:, **options)
      @http_status = http_status
      @error_code = error_code
      @error_reason = error_reason
      @status = options[:status]
    end

    # @return [Hash] attribute keys and values
    def attributes
      ATTRIBUTES.each_with_object({}) do |attr, hash|
        hash[attr] = public_send(attr)
      end
    end
  end
end
