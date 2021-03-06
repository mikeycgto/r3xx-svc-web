# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_18_222451) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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

  create_table "hits", force: :cascade do |t|
    t.integer "link_id", null: false
    t.string "remote_address", null: false
    t.string "user_agent", null: false
    t.string "location_country_code"
    t.string "location_country_name"
    t.string "location_region_name"
    t.string "location_city_name"
    t.string "client_browser_name"
    t.string "client_browser_version"
    t.string "client_device_name"
    t.string "client_device_type"
    t.string "client_os_name"
    t.string "client_os_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_hits_on_created_at"
    t.index ["link_id"], name: "index_hits_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.integer "user_id"
    t.string "domain", null: false
    t.string "ident", null: false
    t.string "url", null: false
    t.integer "hits_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ident"], name: "index_links_on_ident", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "misses", force: :cascade do |t|
    t.string "link_ident", null: false
    t.string "domain", null: false
    t.string "remote_address", null: false
    t.string "user_agent", null: false
    t.boolean "recorded_as_hit", default: false, null: false
    t.string "location_country_code"
    t.string "location_country_name"
    t.string "location_region_name"
    t.string "location_city_name"
    t.string "client_browser_name"
    t.string "client_browser_version"
    t.string "client_device_name"
    t.string "client_device_type"
    t.string "client_os_name"
    t.string "client_os_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_misses_on_created_at"
    t.index ["link_ident"], name: "index_misses_on_link_ident"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "links_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
