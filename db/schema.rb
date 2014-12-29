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

ActiveRecord::Schema.define(version: 20141228120500) do

  create_table "comments", force: true do |t|
    t.text     "content"
    t.boolean  "owner_flag", default: false
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["subject_id", "created_at"], name: "index_comments_on_subject_id_and_created_at"

  create_table "diaries", force: true do |t|
    t.date     "day"
    t.string   "todo"
    t.string   "done"
    t.integer  "progress"
    t.string   "memo"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diaries", ["subject_id"], name: "index_diaries_on_subject_id"

  create_table "materials", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "materials", ["subject_id"], name: "index_materials_on_subject_id"

  create_table "subjects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.integer  "user_id"
    t.date     "start_day"
    t.date     "end_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["url"], name: "index_subjects_on_url", unique: true
  add_index "subjects", ["user_id", "created_at"], name: "index_subjects_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
