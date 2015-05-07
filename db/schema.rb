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

ActiveRecord::Schema.define(version: 20150507071951) do

  create_table "article_lists", force: :cascade do |t|
    t.integer  "article_id", limit: 4
    t.text     "content",    limit: 65535
    t.text     "translate",  limit: 65535
    t.text     "remark_on",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "status",     limit: 4,     default: 0
    t.text     "content",    limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "cover_path", limit: 255
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "weight",     limit: 4,   default: 0
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",          limit: 65535
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id",          limit: 4
    t.text     "content_html",     limit: 65535
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", length: {"commentable_id"=>nil, "commentable_type"=>100}, using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "content",     limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id",     limit: 4
    t.string   "author",      limit: 255
    t.integer  "status",      limit: 4,     default: 0
    t.integer  "watch_count", limit: 4,     default: 0
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "product_category_ships", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "product_category_ships", ["category_id"], name: "index_product_category_ships_on_category_id", using: :btree
  add_index "product_category_ships", ["product_id", "category_id"], name: "index_product_category_ships_on_product_id_and_category_id", unique: true, using: :btree
  add_index "product_category_ships", ["product_id"], name: "index_product_category_ships_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.text     "describe",   limit: 65535
    t.string   "cover_path", limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_collect_products", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_collect_products", ["product_id", "user_id"], name: "index_user_collect_products_on_product_id_and_user_id", unique: true, using: :btree
  add_index "user_collect_products", ["product_id"], name: "index_user_collect_products_on_product_id", using: :btree
  add_index "user_collect_products", ["user_id"], name: "index_user_collect_products_on_user_id", using: :btree

  create_table "user_collects", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "listable_id",   limit: 4
    t.string   "listable_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "user_collects", ["listable_id", "listable_type"], name: "index_user_collects_on_listable_id_and_listable_type", length: {"listable_id"=>nil, "listable_type"=>100}, using: :btree
  add_index "user_collects", ["listable_id"], name: "index_user_collects_on_listable_id", using: :btree
  add_index "user_collects", ["user_id"], name: "index_user_collects_on_user_id", using: :btree

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "gender",     limit: 255,   default: "secrecy"
    t.text     "resume",     limit: 65535
    t.string   "website",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id", using: :btree

  create_table "user_tag_ships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_tag_ships", ["tag_id"], name: "index_user_tag_ships_on_tag_id", using: :btree
  add_index "user_tag_ships", ["user_id", "tag_id"], name: "index_user_tag_ships_on_user_id_and_tag_id", unique: true, using: :btree
  add_index "user_tag_ships", ["user_id"], name: "index_user_tag_ships_on_user_id", using: :btree

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
    t.integer  "user_id",         limit: 4
  end

  create_table "wechat_infos", force: :cascade do |t|
    t.string   "public_name", limit: 255
    t.string   "number",      limit: 255
    t.string   "qr_code",     limit: 255
    t.string   "keyword",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",     limit: 4
  end

  add_index "wechat_infos", ["user_id"], name: "index_wechat_infos_on_user_id", using: :btree

end
