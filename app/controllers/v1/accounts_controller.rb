# frozen_string_literal: true

# Opens V1 namespace
module V1
  # Creates AccountsController class
  class AccountsController < ApplicationController
    # GET /:account_id/transactions
    def transactions
      render json: transactions_service.execute!
    end

    # POST /create
    def create
      render json: create_service.execute!
    end

    private

    def create_params
      params.permit(*Account::ATTRIBUTES)
    end

    def create_service
      Accounts::CreateService.new(params: create_params)
    end

    def transactions_service
      Accounts::TransactionsService.new(params: params)
    end
  end
end
