# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160227192106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "fetch_url"
    t.string   "slug"
    t.boolean  "published",    default: false, null: false
    t.boolean  "popular",      default: false, null: false
    t.boolean  "very_popular", default: false, null: false
    t.integer  "person_id",                    null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "image"
  end

  add_index "books", ["person_id"], name: "index_books_on_person_id", using: :btree
  add_index "books", ["slug"], name: "index_books_on_slug", using: :btree

  create_table "character_sources", force: :cascade do |t|
    t.integer  "character_id", null: false
    t.integer  "source_id",    null: false
    t.string   "source_type",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "character_sources", ["character_id"], name: "index_character_sources_on_character_id", using: :btree
  add_index "character_sources", ["source_type", "source_id"], name: "index_character_sources_on_source_type_and_source_id", using: :btree

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "image"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "published",    default: false, null: false
    t.boolean  "popular",      default: false, null: false
    t.boolean  "very_popular", default: false, null: false
  end

  create_table "featured_topics", force: :cascade do |t|
    t.integer  "source_id",   null: false
    t.string   "source_type", null: false
    t.integer  "topic_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "featured_topics", ["source_type", "source_id"], name: "index_featured_topics_on_source_type_and_source_id", using: :btree
  add_index "featured_topics", ["topic_id"], name: "index_featured_topics_on_topic_id", using: :btree

  create_table "nationalities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "fetch_url"
    t.boolean  "published",      default: false, null: false
    t.boolean  "popular",        default: false, null: false
    t.boolean  "very_popular",   default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image"
    t.integer  "nationality_id"
    t.integer  "profession_id"
  end

  add_index "people", ["slug"], name: "index_people_on_slug", using: :btree

  create_table "professions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quote_topic_suggestions", force: :cascade do |t|
    t.integer  "quote_id",                   null: false
    t.integer  "topic_id",                   null: false
    t.boolean  "read",       default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "quote_topic_suggestions", ["quote_id"], name: "index_quote_topic_suggestions_on_quote_id", using: :btree
  add_index "quote_topic_suggestions", ["topic_id"], name: "index_quote_topic_suggestions_on_topic_id", using: :btree

  create_table "quote_topics", force: :cascade do |t|
    t.integer  "quote_id",   null: false
    t.integer  "topic_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "quote_topics", ["quote_id"], name: "index_quote_topics_on_quote_id", using: :btree
  add_index "quote_topics", ["topic_id"], name: "index_quote_topics_on_topic_id", using: :btree

  create_table "quoted_in_books", force: :cascade do |t|
    t.string   "name"
    t.string   "author"
    t.integer  "quote_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "chapter"
    t.integer  "page"
  end

  add_index "quoted_in_books", ["quote_id"], name: "index_quoted_in_books_on_quote_id", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.text     "text"
    t.integer  "source_id",                           null: false
    t.string   "source_type",                         null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "twitter_share_count",     default: 0
    t.integer  "facebook_share_count",    default: 0
    t.integer  "pinterest_share_count",   default: 0
    t.integer  "google_plus_share_count", default: 0
    t.integer  "total_share_count",       default: 0
    t.integer  "character_id"
  end

  add_index "quotes", ["character_id"], name: "index_quotes_on_character_id", using: :btree
  add_index "quotes", ["source_type", "source_id"], name: "index_quotes_on_source_type_and_source_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.text     "google_analytics"
    t.string   "bing_verification"
    t.string   "alexa_verification"
    t.string   "google_verification"
    t.string   "yandex_verification"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "title"
    t.text     "description"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "google_plus_url"
    t.string   "pinterest_url"
  end

  create_table "time_lines", force: :cascade do |t|
    t.integer  "item_id",    null: false
    t.string   "item_type",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "time_lines", ["item_type", "item_id"], name: "index_time_lines_on_item_type_and_item_id", using: :btree

  create_table "topic_aliases", force: :cascade do |t|
    t.string   "name"
    t.integer  "topic_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topic_aliases", ["topic_id"], name: "index_topic_aliases_on_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "popular",      default: false, null: false
    t.boolean  "very_popular", default: false, null: false
    t.boolean  "published",    default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "image"
  end

  add_index "topics", ["slug"], name: "index_topics_on_slug", using: :btree

  add_foreign_key "books", "people"
  add_foreign_key "character_sources", "characters"
  add_foreign_key "quote_topic_suggestions", "quotes"
  add_foreign_key "quote_topic_suggestions", "topics"
  add_foreign_key "quote_topics", "quotes"
  add_foreign_key "quote_topics", "topics"
  add_foreign_key "quoted_in_books", "quotes"
  add_foreign_key "quotes", "characters"
  add_foreign_key "topic_aliases", "topics"
end
