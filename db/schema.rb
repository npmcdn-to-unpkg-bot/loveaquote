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

ActiveRecord::Schema.define(version: 20160321134727) do

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
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "image"
    t.string   "isbn"
  end

  add_index "books", ["slug"], name: "index_books_on_slug", using: :btree

  create_table "chapter_and_pages", force: :cascade do |t|
    t.integer  "quote_id",   null: false
    t.integer  "chapter"
    t.integer  "page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chapter_and_pages", ["quote_id"], name: "index_chapter_and_pages_on_quote_id", using: :btree

  create_table "character_sources", force: :cascade do |t|
    t.integer  "character_id", null: false
    t.integer  "source_id",    null: false
    t.string   "source_type",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "person_id"
  end

  add_index "character_sources", ["character_id"], name: "index_character_sources_on_character_id", using: :btree
  add_index "character_sources", ["person_id"], name: "index_character_sources_on_person_id", using: :btree
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

  create_table "color_schemes", force: :cascade do |t|
    t.string   "background_color"
    t.string   "foreground_color"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "compositions", force: :cascade do |t|
    t.integer  "person_id",  null: false
    t.integer  "book_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "compositions", ["book_id"], name: "index_compositions_on_book_id", using: :btree
  add_index "compositions", ["person_id"], name: "index_compositions_on_person_id", using: :btree

  create_table "featured_topics", force: :cascade do |t|
    t.integer  "source_id",   null: false
    t.string   "source_type", null: false
    t.integer  "topic_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "featured_topics", ["source_type", "source_id"], name: "index_featured_topics_on_source_type_and_source_id", using: :btree
  add_index "featured_topics", ["topic_id"], name: "index_featured_topics_on_topic_id", using: :btree

  create_table "found_ats", force: :cascade do |t|
    t.string   "link"
    t.integer  "quote_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "found_ats", ["quote_id"], name: "index_found_ats_on_quote_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "sub_category"
  end

  add_index "logs", ["source_type", "source_id"], name: "index_logs_on_source_type_and_source_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "read",       default: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "published"
    t.boolean  "popular"
    t.boolean  "very_popular"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

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
    t.date     "born"
    t.date     "died"
  end

  add_index "people", ["slug"], name: "index_people_on_slug", using: :btree

  create_table "professions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proverbs", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "published"
    t.boolean  "popular"
    t.boolean  "very_popular"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "quote_of_the_days", force: :cascade do |t|
    t.date     "date"
    t.integer  "quote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "quote_of_the_days", ["quote_id"], name: "index_quote_of_the_days_on_quote_id", using: :btree

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
    t.string   "isbn"
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
    t.integer  "quote_of_the_day_count",  default: 0
  end

  add_index "quotes", ["character_id"], name: "index_quotes_on_character_id", using: :btree
  add_index "quotes", ["source_type", "source_id"], name: "index_quotes_on_source_type_and_source_id", using: :btree

  create_table "redirects", force: :cascade do |t|
    t.string   "from"
    t.string   "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.date     "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "reviews", ["source_type", "source_id"], name: "index_reviews_on_source_type_and_source_id", using: :btree

  create_table "search_suggestions", force: :cascade do |t|
    t.string   "name"
    t.integer  "source_id",   null: false
    t.string   "source_type", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "search_suggestions", ["source_type", "source_id"], name: "index_search_suggestions_on_source_type_and_source_id", using: :btree

  create_table "season_and_episodes", force: :cascade do |t|
    t.integer  "quote_id",   null: false
    t.integer  "season"
    t.integer  "episode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "season_and_episodes", ["quote_id"], name: "index_season_and_episodes_on_quote_id", using: :btree

  create_table "seos", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "source_id"
    t.string   "source_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "seos", ["source_type", "source_id"], name: "index_seos_on_source_type_and_source_id", using: :btree

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

  create_table "social_images", force: :cascade do |t|
    t.integer  "source_id",   null: false
    t.string   "source_type", null: false
    t.string   "twitter"
    t.string   "facebook"
    t.string   "google_plus"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "pinterest"
  end

  add_index "social_images", ["source_type", "source_id"], name: "index_social_images_on_source_type_and_source_id", using: :btree

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

  create_table "topic_combinations", force: :cascade do |t|
    t.integer  "primary_topic_id",   null: false
    t.integer  "secondary_topic_id", null: false
    t.string   "slug"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "topic_combinations", ["primary_topic_id"], name: "index_topic_combinations_on_primary_topic_id", using: :btree
  add_index "topic_combinations", ["secondary_topic_id"], name: "index_topic_combinations_on_secondary_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "popular",      default: false, null: false
    t.boolean  "very_popular", default: false, null: false
    t.boolean  "published",    default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "image"
    t.string   "byline"
  end

  add_index "topics", ["slug"], name: "index_topics_on_slug", using: :btree

  create_table "tv_shows", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "published"
    t.boolean  "popular"
    t.boolean  "very_popular"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_searches", force: :cascade do |t|
    t.string   "text"
    t.integer  "source_id"
    t.string   "source_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_searches", ["source_type", "source_id"], name: "index_user_searches_on_source_type_and_source_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "chapter_and_pages", "quotes"
  add_foreign_key "character_sources", "characters"
  add_foreign_key "character_sources", "people"
  add_foreign_key "compositions", "books"
  add_foreign_key "compositions", "people"
  add_foreign_key "found_ats", "quotes"
  add_foreign_key "quote_of_the_days", "quotes"
  add_foreign_key "quote_topic_suggestions", "quotes"
  add_foreign_key "quote_topic_suggestions", "topics"
  add_foreign_key "quote_topics", "quotes"
  add_foreign_key "quote_topics", "topics"
  add_foreign_key "quoted_in_books", "quotes"
  add_foreign_key "quotes", "characters", on_delete: :nullify
  add_foreign_key "season_and_episodes", "quotes"
  add_foreign_key "topic_aliases", "topics"
  add_foreign_key "topic_combinations", "topics", column: "primary_topic_id", on_delete: :cascade
  add_foreign_key "topic_combinations", "topics", column: "secondary_topic_id", on_delete: :cascade
end
