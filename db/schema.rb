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

ActiveRecord::Schema.define(version: 20171022223917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_additional_fields_on_category_id", using: :btree
  end

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id", using: :btree
  end

  create_table "categories_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.integer  "likes",         default: 0
    t.integer  "dislikes",      default: 0
    t.integer  "inappropriate", default: 0
    t.integer  "category_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "encoded_image"
    t.text     "description"
    t.jsonb    "metadata"
    t.index ["category_id"], name: "index_places_on_category_id", using: :btree
  end

  create_table "places_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "place_id", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["place_id"], name: "index_ratings_on_place_id", using: :btree
    t.index ["user_id"], name: "index_ratings_on_user_id", using: :btree
  end

  create_table "revisions", force: :cascade do |t|
    t.integer  "positive",          default: 0
    t.integer  "negative",          default: 0
    t.string   "revisionable_type"
    t.integer  "revisionable_id"
    t.string   "proposable_type"
    t.integer  "proposable_id"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["proposable_type", "proposable_id"], name: "index_revisions_on_proposable_type_and_proposable_id", using: :btree
    t.index ["revisionable_type", "revisionable_id"], name: "index_revisions_on_revisionable_type_and_revisionable_id", using: :btree
    t.index ["user_id"], name: "index_revisions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "additional_fields", "categories"
  add_foreign_key "api_keys", "users"
  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "places", "categories"
  add_foreign_key "ratings", "places"
  add_foreign_key "ratings", "users"
  add_foreign_key "revisions", "users"
end
