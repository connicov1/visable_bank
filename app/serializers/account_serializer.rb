# frozen_string_literal: true

# Creates AccountSerializer class
class AccountSerializer < ApplicationSerializer
  attribute :id
  attributes(*Account::ATTRIBUTES)
end
