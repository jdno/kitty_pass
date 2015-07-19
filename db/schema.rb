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

ActiveRecord::Schema.define(version: 20150719071215) do

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
    t.integer  "model_id"
    t.integer  "status_id"
    t.string   "ipv4_gateway"
    t.string   "ipv6_gateway"
    t.integer  "location_id"
    t.integer  "xha_cluster_id"
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

  create_table "proteus", force: :cascade do |t|
    t.string   "hostname"
    t.string   "identifier"
    t.string   "serial_number"
    t.string   "inventory_number"
    t.string   "root_password"
    t.string   "ipv4_gateway"
    t.string   "ipv6_gateway"
    t.integer  "model_id"
    t.integer  "status_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "location_id"
  end

  add_index "proteus", ["hostname"], name: "index_proteus_on_hostname", unique: true
  add_index "proteus", ["identifier"], name: "index_proteus_on_identifier", unique: true

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "statuses", ["name"], name: "index_statuses_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "xha_clusters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xhas", force: :cascade do |t|
    t.integer  "master_id"
    t.integer  "slave_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "xhas", ["master_id", "slave_id"], name: "index_xhas_on_master_id_and_slave_id"

end
