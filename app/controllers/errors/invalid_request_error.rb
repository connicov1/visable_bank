# frozen_string_literal: true

# Opens Errors namespace
module Errors
  # Creates InvalidRequestError exception class to be used when requests are invalid.
  class InvalidRequestError < StandardError
    # Defindes error code
    #
    # @return [Symbol]
    def error_code
      :invalid_request
    end

    # Defines error message
    #
    # @return [String]
    def message
      'Invalid request'
    end
  end
end
