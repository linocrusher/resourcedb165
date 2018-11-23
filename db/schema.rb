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

ActiveRecord::Schema.define(version: 20181122103309) do

  create_table "folders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "resource_thread_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_thread_id"], name: "index_folders_on_resource_thread_id"
  end

  create_table "keywords", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "instances"
  end

  create_table "resource_threads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "resource_count"
    t.index ["user_id"], name: "index_resource_threads_on_user_id"
  end

  create_table "resources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "trust", limit: 24
    t.text "text"
    t.bigint "resource_thread_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_thread_id"], name: "index_resources_on_resource_thread_id"
  end

  create_table "rfiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "resource_id"
    t.bigint "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_rfiles_on_folder_id"
    t.index ["resource_id"], name: "index_rfiles_on_resource_id"
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "resource_thread_id"
    t.bigint "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_tags_on_keyword_id"
    t.index ["resource_thread_id"], name: "index_tags_on_resource_thread_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "password"
    t.datetime "date_created"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salt"
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "value"
    t.bigint "user_id"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_votes_on_resource_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "folders", "resource_threads"
  add_foreign_key "resource_threads", "users"
  add_foreign_key "resources", "resource_threads"
  add_foreign_key "rfiles", "folders"
  add_foreign_key "rfiles", "resources"
  add_foreign_key "tags", "keywords"
  add_foreign_key "tags", "resource_threads"
  add_foreign_key "votes", "resources"
  add_foreign_key "votes", "users"
end
