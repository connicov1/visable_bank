# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    sequence(:id) { SecureRandom.uuid }

    description { "P2P transfer" }
    amount { "10.0" }
    transaction_type { "transfer" }
    currency { "EUR" }
    status { "completed" }
    date { Time.zone.now.to_date.to_s }
    account_id { '' }
    receiver_account_id { "927878a1-21e5-4885-a731-334cbc678404" }
  end
end
