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

ActiveRecord::Schema.define(version: 20160501094020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interest_categories", force: :cascade do |t|
    t.string   "category",   null: false
    t.string   "place",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_interests", force: :cascade do |t|
    t.integer  "user_id",              null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "sub_category"
    t.integer  "interest_category_id", null: false
    t.string   "interest_name",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name"
    t.date     "dob",             null: false
    t.string   "gender",          null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.float    "home_latitude",   null: false
    t.float    "home_longitude",  null: false
    t.string   "preference",      null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "user_interests", "interest_categories"
  add_foreign_key "user_interests", "users"
end
