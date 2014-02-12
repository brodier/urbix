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

ActiveRecord::Schema.define(version: 20140212170008) do

  create_table "addresses", force: true do |t|
    t.string   "address"
    t.integer  "locality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["locality_id"], name: "index_addresses_on_locality_id"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "a2code"
    t.string   "a3code"
    t.integer  "num_code"
    t.integer  "dial_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localities", force: true do |t|
    t.string   "name"
    t.string   "zip"
    t.integer  "city_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "localities", ["city_id"], name: "index_localities_on_city_id"
  add_index "localities", ["country_id"], name: "index_localities_on_country_id"

  create_table "mails", force: true do |t|
    t.text     "content"
    t.integer  "exp_id"
    t.integer  "dst_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mails", ["dst_id"], name: "index_mails_on_dst_id"
  add_index "mails", ["exp_id"], name: "index_mails_on_exp_id"

end
