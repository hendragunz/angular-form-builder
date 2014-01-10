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

ActiveRecord::Schema.define(version: 20140108230217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "evaluation_form_questions", force: true do |t|
    t.string   "name"
    t.text     "en_label"
    t.text     "fr_label"
    t.text     "en_hint"
    t.text     "fr_hint"
    t.string   "question_type"
    t.hstore   "properties"
    t.boolean  "required",           default: true
    t.integer  "position",           default: 0
    t.integer  "evaluation_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluation_forms", force: true do |t|
    t.string   "name"
    t.boolean  "active",       default: true
    t.text     "scope"
    t.text     "introduction"
    t.text     "conclusion"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.datetime "date"
    t.integer  "procedure_id"
    t.string   "evaluation_form_id"
    t.integer  "evaluator_id"
    t.integer  "resident_id"
    t.hstore   "answers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.string   "username"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
