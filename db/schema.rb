# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_30_105916) do

  create_table "accounts", id: { type: :string, limit: 36 }, charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "iban", null: false
    t.string "currency", null: false
    t.string "nature", default: "account"
    t.string "status", default: "active"
    t.decimal "balance", precision: 10, default: "0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "iban"], name: "index_accounts_on_name_and_iban", unique: true
  end

  create_table "transactions", id: { type: :string, limit: 36 }, charset: "utf8", force: :cascade do |t|
    t.text "description"
    t.string "amount", null: false
    t.string "transaction_type", default: "transfer"
    t.string "currency", null: false
    t.string "status", default: "pending"
    t.string "date", null: false
    t.string "account_id", limit: 36, null: false
    t.string "receiver_account_id", limit: 36, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "account_id"
  end

  add_foreign_key "transactions", "accounts", name: "transactions_ibfk_1"
end
