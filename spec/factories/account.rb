# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:id) { SecureRandom.uuid }

    name { 'Test Account' }
    iban { 'TESTIBAN123123' }
    currency { 'EUR' }
    nature { 'account' }
    status { 'active' }
    balance { 0 }

    trait :with_transactions do
      after(:create) do |account|
        5.times do
          create(:transaction, account_id: account.id)
        end
      end
    end
  end
end
