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

ActiveRecord::Schema.define(version: 20140224215011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "accounts", force: true do |t|
    t.integer  "owner_id"
    t.integer  "plan_id"
    t.integer  "trial_days_left", default: 14
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_options", force: true do |t|
    t.integer  "form_field_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_entries", force: true do |t|
    t.integer  "form_id"
    t.hstore   "answers"
    t.text     "user_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_fields", force: true do |t|
    t.string   "name"
    t.text     "field_label"
    t.text     "field_hint"
    t.string   "field_type"
    t.hstore   "properties"
    t.integer  "scale"
    t.string   "options"
    t.string   "true_label"
    t.string   "false_label"
    t.boolean  "required",    default: true
    t.integer  "position",    default: 0
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size"
    t.integer  "page",        default: 1,    null: false
    t.string   "show_to"
  end

  create_table "forms", force: true do |t|
    t.string   "name"
    t.string   "slug",                                      null: false
    t.text     "introduction"
    t.text     "confirmation_message"
    t.integer  "max_entries_allowed"
    t.boolean  "unique_ip_only",            default: false
    t.boolean  "send_email_confirmation",   default: false
    t.boolean  "show_questions_one_by_one", default: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "persons_to_notify"
    t.integer  "entries_count",             default: 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forms", ["slug"], name: "index_forms_on_slug", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                           default: false
    t.boolean  "active",                          default: true
    t.integer  "account_id"
    t.string   "localization",                    default: "fr"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "access_token"
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
