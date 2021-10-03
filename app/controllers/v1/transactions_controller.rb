# frozen_string_literal: true

# Opens V1 namespace
module V1
  # Creates TransactionsController class
  class TransactionsController < ApplicationController
    # POST /transactions
    def create
      render json: create_service.execute!
    end

    private

    def create_params
      params.permit(*Transactions::Request::Create::ATTRIBUTES)
    end

    def create_service
      Transactions::Request::CreateService.new(create_params)
    end
  end
end
