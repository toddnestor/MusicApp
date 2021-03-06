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

ActiveRecord::Schema.define(version: 20161007002401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer  "band_id",                                                null: false
    t.string   "album_type",     default: "studio",                      null: false
    t.string   "name",                                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.text     "featured_image", default: "http://placehold.it/242x200"
    t.integer  "user_id",        default: 1,                             null: false
    t.index ["band_id"], name: "index_albums_on_band_id", using: :btree
  end

  create_table "bands", force: :cascade do |t|
    t.string   "name",                                                                                                            null: false
    t.text     "featured_image", default: "http://az616578.vo.msecnd.net/files/2016/07/11/6360384265838540902094315765_band.jpg"
    t.datetime "created_at",                                                                                                      null: false
    t.datetime "updated_at",                                                                                                      null: false
    t.integer  "user_id",        default: 1,                                                                                      null: false
    t.index ["name"], name: "index_bands_on_name", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
    t.index ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",       null: false
    t.string   "tagable_type", null: false
    t.integer  "tagable_id",   null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["tag_id", "tagable_type", "tagable_id"], name: "index_taggings_on_tag_id_and_tagable_type_and_tagable_id", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["tagable_id"], name: "index_taggings_on_tagable_id", using: :btree
    t.index ["tagable_type"], name: "index_taggings_on_tagable_type", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", using: :btree
  end

  create_table "tracks", force: :cascade do |t|
    t.text     "lyrics"
    t.integer  "album_id",                       null: false
    t.string   "track_type", default: "regular", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "name",                           null: false
    t.integer  "user_id",    default: 1,         null: false
    t.index ["album_id"], name: "index_tracks_on_album_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            null: false
    t.string   "password_digest",                  null: false
    t.string   "session_token",                    null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "activated",        default: false
    t.string   "activation_token"
    t.boolean  "admin",            default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  end

end
