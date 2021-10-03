# frozen_string_literal: true

# Creates CreateAccountsTable migration class
class CreateAccountsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :string, limit: 36 do |t|
      t.string :name, null: false
      t.string :iban, null: false
      t.string :currency, null: false
      t.string :nature, default: 'account'
      t.string :status, default: 'active'
      t.decimal :balance, default: 0.0

      t.index [:name, :iban], unique: true

      t.timestamps
    end
  end
end
