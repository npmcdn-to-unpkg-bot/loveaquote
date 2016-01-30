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

ActiveRecord::Schema.define(version: 20160129020856) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "fetch_url"
    t.boolean  "published",    default: false, null: false
    t.boolean  "popular",      default: false, null: false
    t.boolean  "very_popular", default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "authors", ["slug"], name: "index_authors_on_slug"

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "fetch_url"
    t.string   "slug"
    t.boolean  "published",    default: false, null: false
    t.boolean  "popular",      default: false, null: false
    t.boolean  "very_popular", default: false, null: false
    t.integer  "author_id",                    null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["slug"], name: "index_books_on_slug"

  create_table "quote_topic_suggestions", force: :cascade do |t|
    t.integer  "quote_id",                   null: false
    t.integer  "topic_id",                   null: false
    t.boolean  "read",       default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "quote_topic_suggestions", ["quote_id"], name: "index_quote_topic_suggestions_on_quote_id"
  add_index "quote_topic_suggestions", ["topic_id"], name: "index_quote_topic_suggestions_on_topic_id"

  create_table "quote_topics", force: :cascade do |t|
    t.integer  "quote_id",   null: false
    t.integer  "topic_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "quote_topics", ["quote_id"], name: "index_quote_topics_on_quote_id"
  add_index "quote_topics", ["topic_id"], name: "index_quote_topics_on_topic_id"

  create_table "quotes", force: :cascade do |t|
    t.text     "text"
    t.integer  "source_id",   null: false
    t.string   "source_type", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "quotes", ["source_type", "source_id"], name: "index_quotes_on_source_type_and_source_id"

  create_table "topic_aliases", force: :cascade do |t|
    t.string   "name"
    t.integer  "topic_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topic_aliases", ["topic_id"], name: "index_topic_aliases_on_topic_id"

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "popular",      default: false, null: false
    t.boolean  "very_popular", default: false, null: false
    t.boolean  "published",    default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "topics", ["slug"], name: "index_topics_on_slug"

end
