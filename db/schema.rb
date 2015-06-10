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

ActiveRecord::Schema.define(version: 20150610075148) do

  create_table "adonis", force: :cascade do |t|
    t.string   "hostname"
    t.string   "identifier"
    t.string   "serial_number"
    t.string   "inventory_number"
    t.string   "root_password"
    t.string   "admin_password"
    t.string   "deploy_password"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "models_id"
    t.integer  "statuses_id"
  end

  add_index "adonis", ["hostname"], name: "index_adonis_on_hostname", unique: true
  add_index "adonis", ["identifier"], name: "index_adonis_on_identifier", unique: true

  create_table "locations", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "locations", ["name"], name: "index_locations_on_name", unique: true

  create_table "models", force: :cascade do |t|
    t.string   "name"
    t.date     "eol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "models", ["name"], name: "index_models_on_name", unique: true

  create_table "network_interfaces", force: :cascade do |t|
    t.string   "name"
    t.string   "mac_address"
    t.string   "ipv4_address"
    t.string   "ipv4_netmask"
    t.string   "ipv6_address"
    t.integer  "ipv6_prefix"
    t.integer  "networkable_id"
    t.string   "networkable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "network_interfaces", ["name", "networkable_id", "networkable_type"], name: "index_network_interfaces", unique: true

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "statuses", ["name"], name: "index_statuses_on_name", unique: true

end
