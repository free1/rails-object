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

ActiveRecord::Schema.define(version: 20150225033041) do

  create_table "products", force: :cascade do |t|
    t.text     "describe",   limit: 65535
    t.string   "cover_path", limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "user_collect_products", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_collect_products", ["product_id", "user_id"], name: "index_user_collect_products_on_product_id_and_user_id", unique: true, using: :btree
  add_index "user_collect_products", ["product_id"], name: "index_user_collect_products_on_product_id", using: :btree
  add_index "user_collect_products", ["user_id"], name: "index_user_collect_products_on_user_id", using: :btree

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "gender",     limit: 255,   default: "secrecy"
    t.text     "resume",     limit: 65535
    t.string   "website",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 255
    t.string   "remember_token",  limit: 255
    t.string   "verify_token",    limit: 255
    t.boolean  "is_verify_email", limit: 1,   default: false
    t.string   "avatar_path",     limit: 255
    t.boolean  "is_email_push",   limit: 1,   default: true
  end

end
