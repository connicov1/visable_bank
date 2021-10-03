# frozen_string_literal: true

# Creates CreateTransactionsTable migration class
class CreateTransactionsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :string, limit: 36 do |t|
      t.text :description
      t.string :amount, null: false
      t.string :transaction_type, default: 'transfer'
      t.string :currency, null: false
      t.string :status, default: 'pending'
      t.string :date, null: false
      t.string :account_id, null: false, limit: 36
      t.string :receiver_account_id, null: false, limit: 36

      t.timestamps
    end

    execute 'ALTER TABLE transactions ADD FOREIGN KEY(account_id) REFERENCES accounts(id)'
  end
end
