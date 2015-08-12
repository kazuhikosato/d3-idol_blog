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

ActiveRecord::Schema.define(version: 20150731071537) do

  create_table "affiliations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "birthplaces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 500
    t.datetime "datetime"
    t.integer  "access",     limit: 4,   default: 0
    t.integer  "idol_id",    limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "blogs", ["idol_id"], name: "index_blogs_on_idol_id", using: :btree

  create_table "idol_teams", force: :cascade do |t|
    t.integer  "idol_id",    limit: 4
    t.integer  "team_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "idol_teams", ["idol_id"], name: "index_idol_teams_on_idol_id", using: :btree
  add_index "idol_teams", ["team_id"], name: "index_idol_teams_on_team_id", using: :btree

  create_table "idols", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "kana",          limit: 255
    t.string   "image_url",     limit: 255
    t.date     "birthday"
    t.integer  "birthplace_id", limit: 4
    t.string   "url",           limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "idols", ["birthplace_id"], name: "index_idols_on_birthplace_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "affiliation_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "teams", ["affiliation_id"], name: "index_teams_on_affiliation_id", using: :btree

  add_foreign_key "blogs", "idols"
  add_foreign_key "idol_teams", "idols"
  add_foreign_key "idol_teams", "teams"
  add_foreign_key "idols", "birthplaces"
  add_foreign_key "teams", "affiliations"
end
