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

ActiveRecord::Schema.define(version: 2021_02_01_134909) do

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "adults", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "adults_children", force: :cascade do |t|
    t.bigint "adult_id", null: false
    t.bigint "child_id", null: false
    t.string "relationship_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["adult_id"], name: "index_adults_children_on_adult_id"
    t.index ["child_id"], name: "index_adults_children_on_child_id"
  end

  create_table "case_documents", force: :cascade do |t|
    t.string "title", null: false
    t.string "document_type", null: false
    t.bigint "case_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "job_id"
    t.index ["case_id"], name: "index_case_documents_on_case_id"
  end

  create_table "case_notes", force: :cascade do |t|
    t.string "title", null: false
    t.string "body", null: false
    t.bigint "case_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["case_id"], name: "index_case_notes_on_case_id"
  end

  create_table "cases", force: :cascade do |t|
    t.string "name", null: false
    t.text "overview"
    t.integer "team_leader"
    t.bigint "referral_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["referral_id"], name: "index_cases_on_referral_id"
  end

  create_table "child_notes", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.text "content"
    t.bigint "author_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_child_notes_on_author_id"
    t.index ["child_id"], name: "index_child_notes_on_child_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "address", null: false
    t.date "dob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "children_cases", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.bigint "case_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["case_id"], name: "index_children_cases_on_case_id"
    t.index ["child_id"], name: "index_children_cases_on_child_id"
  end

  create_table "file_compressors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "job_title", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_cases", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "case_id"
    t.date "assignment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["case_id"], name: "index_users_cases_on_case_id"
    t.index ["user_id"], name: "index_users_cases_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adults_children", "adults"
  add_foreign_key "adults_children", "children"
  add_foreign_key "child_notes", "children"
  add_foreign_key "child_notes", "users", column: "author_id"
  add_foreign_key "children_cases", "cases"
  add_foreign_key "children_cases", "children"
end
