# frozen_string_literal: true

# CurrencyValidations module that valudates currency
module CurrencyValidations
  extend ActiveSupport::Concern

  included do
    validates :currency, currency: true
  end
end
