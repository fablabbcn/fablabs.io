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

ActiveRecord::Schema.define(version: 20131206182044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "activities", force: true do |t|
    t.integer  "creator_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at"
    t.integer  "actor_id"
  end

  add_index "activities", ["actor_id"], name: "index_activities_on_actor_id", using: :btree
  add_index "activities", ["creator_id"], name: "index_activities_on_creator_id", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_applications", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "lab_id"
    t.text     "notes"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_applications", ["applicant_id", "lab_id"], name: "index_admin_applications_on_applicant_id_and_lab_id", using: :btree

  create_table "brands", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "workflow_state"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brands", ["creator_id"], name: "index_brands_on_creator_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "author_id"
    t.string   "ancestry"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree
  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "discussions", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "discussable_id"
    t.string   "discussable_type"
    t.integer  "creator_id"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discussions", ["creator_id"], name: "index_discussions_on_creator_id", using: :btree
  add_index "discussions", ["discussable_id", "discussable_type"], name: "index_discussions_on_discussable_id_and_discussable_type", using: :btree

  create_table "employees", force: true do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.integer  "ordinal"
    t.string   "job_title"
    t.string   "email"
    t.string   "phone"
    t.text     "description"
    t.date     "started_on"
    t.date     "finished_on"
    t.string   "workflow_state"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["creator_id"], name: "index_employees_on_creator_id", using: :btree
  add_index "employees", ["lab_id"], name: "index_employees_on_lab_id", using: :btree
  add_index "employees", ["ordinal"], name: "index_employees_on_ordinal", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "facilities", force: true do |t|
    t.integer  "lab_id"
    t.integer  "thing_id"
    t.text     "notes"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facilities", ["creator_id"], name: "index_facilities_on_creator_id", using: :btree
  add_index "facilities", ["lab_id", "thing_id"], name: "index_facilities_on_lab_id_and_thing_id", unique: true, using: :btree

  create_table "featured_images", force: true do |t|
    t.string   "src"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.string   "workflow_state"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "featured_images", ["creator_id"], name: "index_featured_images_on_creator_id", using: :btree

  create_table "labs", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "ancestry"
    t.integer  "creator_id"
    t.string   "workflow_state"
    t.integer  "capabilities"
    t.string   "time_zone"
    t.string   "avatar_src"
    t.string   "header_image_src"
    t.string   "phone"
    t.string   "email"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "county"
    t.string   "postal_code"
    t.string   "country_code"
    t.string   "subregion"
    t.string   "region"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.text     "address_notes"
    t.text     "reverse_geocoded_address"
    t.integer  "kind"
    t.text     "application_notes"
    t.text     "tools_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "blurb"
    t.integer  "referee_id"
  end

  add_index "labs", ["creator_id"], name: "index_labs_on_creator_id", using: :btree
  add_index "labs", ["referee_id"], name: "index_labs_on_referee_id", using: :btree
  add_index "labs", ["slug"], name: "index_labs_on_slug", unique: true, using: :btree

  create_table "links", force: true do |t|
    t.integer  "linkable_id"
    t.string   "linkable_type"
    t.integer  "ordinal"
    t.string   "url"
    t.string   "description"
    t.string   "workflow_state"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["creator_id"], name: "index_links_on_creator_id", using: :btree
  add_index "links", ["linkable_id", "linkable_type", "ordinal"], name: "index_links_on_linkable_id_and_linkable_type_and_ordinal", using: :btree

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id",              null: false
    t.integer  "application_id",                 null: false
    t.string   "token",                          null: false
    t.integer  "expires_in",                     null: false
    t.string   "redirect_uri",      limit: 2048, null: false
    t.datetime "created_at",                     null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.string   "redirect_uri", limit: 2048, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "recoveries", force: true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.string   "ip"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recoveries", ["user_id"], name: "index_recoveries_on_user_id", using: :btree

  create_table "role_applications", force: true do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.string   "workflow_state"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_applications", ["user_id", "lab_id"], name: "index_role_applications_on_user_id_and_lab_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "things", force: true do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.text     "description"
    t.string   "workflow_state"
    t.string   "ancestry"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_src"
    t.string   "type"
    t.boolean  "inventory_item", default: false
  end

  add_index "things", ["brand_id"], name: "index_things_on_brand_id", using: :btree
  add_index "things", ["creator_id"], name: "index_things_on_creator_id", using: :btree
  add_index "things", ["id", "type", "inventory_item"], name: "index_things_on_id_and_type_and_inventory_item", using: :btree

  create_table "users", force: true do |t|
    t.string   "workflow_state"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "avatar_src"
    t.string   "phone"
    t.string   "city"
    t.string   "country_code"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "url"
    t.date     "dob"
    t.text     "bio"
    t.string   "locale"
    t.string   "time_zone"
    t.boolean  "use_metric",            default: true
    t.string   "email_validation_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
