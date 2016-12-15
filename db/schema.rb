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

ActiveRecord::Schema.define(version: 20161215002040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "player1_id",    null: false
    t.integer  "player2_id",    null: false
    t.integer  "game_id",       null: false
    t.integer  "winner"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "score"
    t.date     "date"
    t.integer  "tournament_id"
  end

  create_table "placings", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "tournament_id", null: false
    t.integer  "placement",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "game_id",       null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "game_id",    null: false
    t.integer  "elo",        null: false
    t.integer  "user_id",    null: false
    t.boolean  "new_player", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "date"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "game_id",    null: false
    t.string   "bracket",    null: false
    t.date     "date",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.string   "profile_picutre"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "current_rating"
    t.string   "current_rank"
    t.index ["current_rating"], name: "index_users_on_current_rating", using: :btree
  end

end
