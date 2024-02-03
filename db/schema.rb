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

ActiveRecord::Schema[7.1].define(version: 2024_01_20_235834) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_settings", id: :string, force: :cascade do |t|
    t.string "account_id", null: false
    t.string "theme", default: "light", null: false
    t.string "language", default: "en", null: false
    t.string "currency", default: "usd", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_settings_on_account_id", unique: true
  end

  create_table "accounts", id: :string, force: :cascade do |t|
    t.string "username", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.jsonb "phone_number", null: false
    t.string "role", default: "customer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["phone_number"], name: "index_accounts_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "product_images", id: :string, force: :cascade do |t|
    t.string "product_id"
    t.string "url", null: false
    t.boolean "primary", default: false, null: false
    t.boolean "thumbnail", default: false, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
    t.index ["url"], name: "index_product_images_on_url", unique: true
  end

  create_table "products", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.integer "price", null: false
    t.integer "discount"
    t.jsonb "details", null: false
    t.jsonb "tags", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "account_settings", "accounts"
  add_foreign_key "product_images", "products"
end
