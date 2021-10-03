# frozen_string_literal: true

# Opens Accounts namespace
module Accounts
  # Creates CreateService class
  class CreateService
    attr_reader :params

    # Defines #initialize method
    #
    # @param params [Hash]
    def initialize(params:)
      @params = params
    end

    # Performs account validations and creates a new account
    #
    # @return [Account]
    def execute!
      validate_request!
      perform_request!

      build_response
    end

    private

    # Validates account model
    #
    # @raise [ActiveRecord::RecordInvalid]
    # @return [Boolean]
    def validate_request!
      account_model.validate!
    end

    # Saves new account in DB
    #
    # @raise [MySQL::Errors]
    # @return [Account]
    def perform_request!
      account_model.save!
    end

    # @return [Account]
    def build_response
      account_model
    end

    # @return [Account]
    def account_model
      @account_model ||= Account.new(params)
    end
  end
end
