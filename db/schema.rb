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

ActiveRecord::Schema.define(version: 2024_02_15_042141) do

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

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "ramen_noodle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_favorites_on_member_id"
    t.index ["ramen_noodle_id"], name: "index_favorites_on_ramen_noodle_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "nickname"
    t.string "comment"
    t.boolean "is_active", default: true
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "ramen_noodle_comments", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "ramen_noodle_id", null: false
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_ramen_noodle_comments_on_member_id"
    t.index ["ramen_noodle_id"], name: "index_ramen_noodle_comments_on_ramen_noodle_id"
  end

  create_table "ramen_noodle_tags", force: :cascade do |t|
    t.integer "ramen_noodle_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ramen_noodle_id", "tag_id"], name: "index_ramen_noodle_tags_on_ramen_noodle_id_and_tag_id", unique: true
    t.index ["ramen_noodle_id"], name: "index_ramen_noodle_tags_on_ramen_noodle_id"
    t.index ["tag_id"], name: "index_ramen_noodle_tags_on_tag_id"
  end

  create_table "ramen_noodles", force: :cascade do |t|
    t.integer "member_id", null: false
    t.string "title"
    t.text "description"
    t.text "recipe"
    t.float "average_rating", default: 0.0
    t.float "taste_rating", default: 0.0
    t.float "cook_time_rating", default: 0.0
    t.float "process_rating", default: 0.0
    t.float "difficulty_rating", default: 0.0
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_ramen_noodles_on_member_id"
  end

  create_table "references", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_references_on_followed_id"
    t.index ["follower_id"], name: "index_references_on_follower_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorites", "members"
  add_foreign_key "favorites", "ramen_noodles"
  add_foreign_key "ramen_noodle_comments", "members"
  add_foreign_key "ramen_noodle_comments", "ramen_noodles"
  add_foreign_key "ramen_noodle_tags", "ramen_noodles"
  add_foreign_key "ramen_noodle_tags", "tags"
  add_foreign_key "ramen_noodles", "members"
  add_foreign_key "references", "followeds"
  add_foreign_key "references", "followers"
  add_foreign_key "relationships", "followeds"
  add_foreign_key "relationships", "followers"
end
