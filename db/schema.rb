# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_19_053255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cecvs", force: :cascade do |t|
    t.string "reg_key"
    t.string "registration_number"
    t.string "fei_number"
    t.string "reg_status_id"
    t.string "initial_importer_flag"
    t.string "reg_expiry_date_year"
    t.string "address_type_id"
    t.string "name"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "city"
    t.string "state_id"
    t.string "iso_country_code"
    t.string "zip_code"
    t.string "postal_code"
  end

  create_table "certifications", force: :cascade do |t|
    t.string "number"
    t.string "category"
    t.string "listing_number"
    t.string "code"
    t.string "authority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_date"
    t.date "expired_date"
  end

  create_table "certifications_products", id: false, force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "certification_id", null: false
  end

  create_table "licenses", force: :cascade do |t|
    t.string "authority"
    t.string "number"
    t.bigint "supplier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "kind"
    t.date "start_date"
    t.date "expired_date"
    t.index ["supplier_id"], name: "index_licenses_on_supplier_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "product_id", null: false
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_messages_on_product_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "destination"
    t.string "price"
    t.string "payment"
    t.boolean "approved"
    t.date "approved_date"
    t.bigint "user_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "confirmed", default: false
    t.index ["supplier_id"], name: "index_offers_on_supplier_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "product_offers", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "offer_id", null: false
    t.string "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["offer_id"], name: "index_product_offers_on_offer_id"
    t.index ["product_id"], name: "index_product_offers_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "category"
    t.integer "production_quantity"
    t.integer "minimum_order_quantity"
    t.bigint "supplier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "industry"
    t.string "delivery_terms"
    t.string "payment_terms"
    t.string "nearest_port"
    t.boolean "whitelisted"
    t.date "established"
    t.string "fei_number"
    t.index ["user_id"], name: "index_suppliers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "country"
    t.string "user_type"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "verifications", force: :cascade do |t|
    t.boolean "veracity_approved", default: false
    t.boolean "valid_registration_license", default: false
    t.boolean "registration_completion", default: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["supplier_id"], name: "index_verifications_on_supplier_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "licenses", "suppliers"
  add_foreign_key "messages", "products"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "offers", "suppliers"
  add_foreign_key "offers", "users"
  add_foreign_key "product_offers", "offers"
  add_foreign_key "product_offers", "products"
  add_foreign_key "products", "suppliers"
  add_foreign_key "suppliers", "users"
  add_foreign_key "verifications", "suppliers"
end
