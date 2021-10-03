# frozen_string_literal: true

# Opens Errors namespace
module Errors
  # Creates UnprocessableEntityError exception class to be used when requests are unprocessable.
  class UnprocessableEntityError < StandardError
    # Defines error code
    #
    # @return [Symbol]
    def error_code
      :unprocessable_entity
    end

    # Defines error message
    #
    # @return [String]
    def message
      'Unprocessable Entity'
    end
  end
end
