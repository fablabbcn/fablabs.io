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



ActiveRecord::Schema.define(version: 20180904121517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "academics", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.integer  "started_in"
    t.string   "type",        limit: 255
    t.integer  "approver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "meta"
  end

  add_index "academics", ["approver_id"], name: "index_academics_on_approver_id", using: :btree
  add_index "academics", ["user_id", "lab_id"], name: "index_academics_on_user_id_and_lab_id", unique: true, using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "action",         limit: 255
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.datetime "created_at"
    t.integer  "actor_id"
  end

  add_index "activities", ["actor_id"], name: "index_activities_on_actor_id", using: :btree
  add_index "activities", ["creator_id"], name: "index_activities_on_creator_id", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_applications", force: :cascade do |t|
    t.integer  "applicant_id"
    t.integer  "lab_id"
    t.text     "notes"
    t.string   "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_applications", ["applicant_id", "lab_id"], name: "index_admin_applications_on_applicant_id_and_lab_id", using: :btree

  create_table "approval_workflow_logs", force: :cascade do |t|
    t.string   "lab_id"
    t.string   "user_id"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "approval_workflow_logs", ["lab_id"], name: "index_approval_workflow_logs_on_lab_id", using: :btree
  add_index "approval_workflow_logs", ["user_id"], name: "index_approval_workflow_logs_on_user_id", using: :btree
  add_index "approval_workflow_logs", ["workflow_state"], name: "index_approval_workflow_logs_on_workflow_state", using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "description"
    t.string   "workflow_state", limit: 255
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brands", ["creator_id"], name: "index_brands_on_creator_id", using: :btree

  create_table "collaborations", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "collaborator_id"
    t.datetime "last_collaboration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborations", ["collaborator_id"], name: "index_collaborations_on_collaborator_id", using: :btree
  add_index "collaborations", ["project_id"], name: "index_collaborations_on_project_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "ancestry",         limit: 255
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree
  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "contributions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "contributor_id"
    t.datetime "last_contribution"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributions", ["contributor_id"], name: "index_contributions_on_contributor_id", using: :btree
  add_index "contributions", ["project_id"], name: "index_contributions_on_project_id", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "description", limit: 255
    t.string   "code",        limit: 255, null: false
    t.integer  "value"
    t.datetime "redeemed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["user_id"], name: "index_coupons_on_user_id", using: :btree

  create_table "discussions", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "body"
    t.integer  "discussable_id"
    t.string   "discussable_type", limit: 255
    t.integer  "creator_id"
    t.string   "workflow_state",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discussions", ["creator_id"], name: "index_discussions_on_creator_id", using: :btree
  add_index "discussions", ["discussable_id", "discussable_type"], name: "index_discussions_on_discussable_id_and_discussable_type", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "type",               limit: 255
    t.string   "title",              limit: 255
    t.text     "description"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "documentable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "documentable_type",  limit: 255
    t.string   "photo_uid",          limit: 255
    t.string   "photo_name",         limit: 255
  end

  add_index "documents", ["documentable_id"], name: "index_documents_on_documentable_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.integer  "ordinal"
    t.string   "job_title",      limit: 255
    t.string   "email",          limit: 255
    t.string   "phone",          limit: 255
    t.text     "description"
    t.date     "started_on"
    t.date     "finished_on"
    t.string   "workflow_state", limit: 255
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["creator_id"], name: "index_employees_on_creator_id", using: :btree
  add_index "employees", ["lab_id"], name: "index_employees_on_lab_id", using: :btree
  add_index "employees", ["ordinal"], name: "index_employees_on_ordinal", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "type",        limit: 255
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "lab_id"
    t.integer  "creator_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tags"
  end

  add_index "events", ["creator_id"], name: "index_events_on_creator_id", using: :btree
  add_index "events", ["lab_id"], name: "index_events_on_lab_id", using: :btree
  add_index "events", ["tags"], name: "index_events_on_tags", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.integer  "lab_id"
    t.integer  "thing_id"
    t.text     "notes"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facilities", ["creator_id"], name: "index_facilities_on_creator_id", using: :btree
  add_index "facilities", ["lab_id", "thing_id"], name: "index_facilities_on_lab_id_and_thing_id", unique: true, using: :btree

  create_table "favourites", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favourites", ["project_id"], name: "index_favourites_on_project_id", using: :btree
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id", using: :btree

  create_table "featured_images", force: :cascade do |t|
    t.string   "src",            limit: 255
    t.string   "name",           limit: 255
    t.string   "description",    limit: 255
    t.string   "url",            limit: 255
    t.string   "workflow_state", limit: 255
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "featured_images", ["creator_id"], name: "index_featured_images_on_creator_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grades", ["project_id"], name: "index_grades_on_project_id", using: :btree
  add_index "grades", ["user_id"], name: "index_grades_on_user_id", using: :btree

  create_table "lab_organizations", force: :cascade do |t|
    t.integer  "lab_id"
    t.integer  "organization_id"
    t.string   "workflow_state",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lab_organizations", ["lab_id"], name: "index_lab_organizations_on_lab_id", using: :btree
  add_index "lab_organizations", ["organization_id"], name: "index_lab_organizations_on_organization_id", using: :btree

  create_table "labs", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "slug",                         limit: 255
    t.text     "description"
    t.string   "ancestry",                     limit: 255
    t.integer  "creator_id"
    t.string   "workflow_state",               limit: 255
    t.integer  "capabilities"
    t.string   "time_zone",                    limit: 255
    t.string   "phone",                        limit: 255
    t.string   "email",                        limit: 255
    t.string   "address_1",                    limit: 255
    t.string   "address_2",                    limit: 255
    t.string   "city",                         limit: 255
    t.string   "county",                       limit: 255
    t.string   "postal_code",                  limit: 255
    t.string   "country_code",                 limit: 255
    t.string   "subregion",                    limit: 255
    t.string   "region",                       limit: 255
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
    t.string   "blurb",                        limit: 255
    t.integer  "referee_id"
    t.boolean  "network",                                  default: false
    t.boolean  "programs",                                 default: false
    t.boolean  "tools",                                    default: false
    t.boolean  "charter",                                  default: false
    t.boolean  "public",                                   default: false
    t.string   "discourse_id",                 limit: 255
    t.text     "discourse_errors"
    t.boolean  "is_referee",                               default: false
    t.string   "avatar_uid",                   limit: 255
    t.string   "avatar_name",                  limit: 255
    t.string   "header_uid",                   limit: 255
    t.string   "header_name",                  limit: 255
    t.string   "activity_status",              limit: 255
    t.date     "activity_start_at"
    t.date     "activity_inaugurated_at"
    t.date     "activity_closed_at"
    t.text     "improve_approval_application"
  end

  add_index "labs", ["creator_id"], name: "index_labs_on_creator_id", using: :btree
  add_index "labs", ["referee_id"], name: "index_labs_on_referee_id", using: :btree
  add_index "labs", ["slug"], name: "index_labs_on_slug", unique: true, using: :btree

  create_table "links", force: :cascade do |t|
    t.integer  "linkable_id"
    t.string   "linkable_type",  limit: 255
    t.integer  "ordinal"
    t.string   "url",            limit: 255
    t.string   "description",    limit: 255
    t.string   "workflow_state", limit: 255
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["creator_id"], name: "index_links_on_creator_id", using: :btree
  add_index "links", ["linkable_id", "linkable_type", "ordinal"], name: "index_links_on_linkable_id_and_linkable_type_and_ordinal", using: :btree

  create_table "machineries", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "machineries", ["device_id"], name: "index_machineries_on_device_id", using: :btree
  add_index "machineries", ["project_id"], name: "index_machineries_on_project_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id",              null: false
    t.integer  "application_id",                 null: false
    t.string   "token",             limit: 255,  null: false
    t.integer  "expires_in",                     null: false
    t.string   "redirect_uri",      limit: 2048, null: false
    t.datetime "created_at",                     null: false
    t.datetime "revoked_at"
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id",                null: false
    t.string   "token",             limit: 255, null: false
    t.string   "refresh_token",     limit: 255
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                    null: false
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         limit: 255,                 null: false
    t.string   "uid",          limit: 255,                 null: false
    t.string   "secret",       limit: 255,                 null: false
    t.string   "redirect_uri", limit: 2048,                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scopes",                    default: "",   null: false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.boolean  "confidential",              default: true, null: false
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.text     "description"
    t.integer  "creator_id"
    t.string   "slug",                     limit: 255
    t.string   "kind",                     limit: 255
    t.string   "blurb",                    limit: 255
    t.string   "phone",                    limit: 255
    t.string   "email",                    limit: 255
    t.text     "application_notes"
    t.string   "discourse_id",             limit: 255
    t.string   "discourse_errors",         limit: 255
    t.string   "workflow_state",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "geojson"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.string   "address_1",                limit: 255
    t.string   "address_2",                limit: 255
    t.string   "city",                     limit: 255
    t.string   "county",                   limit: 255
    t.string   "postal_code",              limit: 255
    t.string   "country_code",             limit: 255
    t.string   "subregion",                limit: 255
    t.string   "region",                   limit: 255
    t.text     "address_notes"
    t.text     "reverse_geocoded_address"
    t.string   "avatar_uid",               limit: 255
    t.string   "avatar_name",              limit: 255
    t.string   "header_uid",               limit: 255
    t.string   "header_name",              limit: 255
    t.integer  "order"
  end

  add_index "organizations", ["order"], name: "index_organizations_on_order", using: :btree
  add_index "organizations", ["slug"], name: "index_organizations_on_slug", unique: true, using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "slug",       limit: 255
    t.text     "content"
    t.integer  "position",               default: 0
    t.boolean  "published",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "type",             limit: 255
    t.string   "title",            limit: 255
    t.text     "description"
    t.integer  "lab_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",           limit: 255
    t.string   "version",          limit: 255
    t.text     "faq"
    t.text     "scope"
    t.text     "community"
    t.text     "lookingfor"
    t.string   "cover",            limit: 255
    t.string   "discourse_id",     limit: 255
    t.text     "discourse_errors"
    t.string   "slug",             limit: 255
    t.integer  "visibility",                   default: 1
  end

  add_index "projects", ["lab_id"], name: "index_projects_on_lab_id", using: :btree
  add_index "projects", ["owner_id"], name: "index_projects_on_owner_id", using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true, using: :btree
  add_index "projects", ["visibility"], name: "index_projects_on_visibility", using: :btree

  create_table "recoveries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "key",            limit: 255
    t.string   "ip",             limit: 255
    t.string   "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recoveries", ["user_id"], name: "index_recoveries_on_user_id", using: :btree

  create_table "referee_approval_processes", force: :cascade do |t|
    t.integer  "referred_lab_id"
    t.integer  "referee_lab_id"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "referee_approval_processes", ["referee_lab_id"], name: "index_referee_approval_processes_on_referee_lab_id", using: :btree
  add_index "referee_approval_processes", ["referred_lab_id"], name: "index_referee_approval_processes_on_referred_lab_id", using: :btree

  create_table "role_applications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lab_id"
    t.string   "workflow_state", limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_applications", ["user_id", "lab_id"], name: "index_role_applications_on_user_id_and_lab_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "steps", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description"
    t.integer  "position"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "steps", ["project_id"], name: "index_steps_on_project_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "things", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "brand_id"
    t.text     "description"
    t.string   "workflow_state",   limit: 255
    t.string   "ancestry",         limit: 255
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",             limit: 255
    t.boolean  "inventory_item",               default: false
    t.string   "discourse_id",     limit: 255
    t.text     "discourse_errors"
    t.string   "photo_uid",        limit: 255
    t.string   "photo_name",       limit: 255
    t.string   "slug",             limit: 255
  end

  add_index "things", ["brand_id"], name: "index_things_on_brand_id", using: :btree
  add_index "things", ["creator_id"], name: "index_things_on_creator_id", using: :btree
  add_index "things", ["id", "type", "inventory_item"], name: "index_things_on_id_and_type_and_inventory_item", using: :btree
  add_index "things", ["slug"], name: "index_things_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "workflow_state",        limit: 255
    t.string   "first_name",            limit: 255
    t.string   "last_name",             limit: 255
    t.string   "email",                 limit: 255
    t.string   "username",              limit: 255
    t.string   "password_digest",       limit: 255
    t.string   "phone",                 limit: 255
    t.string   "city",                  limit: 255
    t.string   "country_code",          limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "url",                   limit: 255
    t.date     "dob"
    t.text     "bio"
    t.string   "locale",                limit: 255
    t.string   "time_zone",             limit: 255
    t.boolean  "use_metric",                        default: true
    t.string   "email_validation_hash", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fab10_coupon_code",     limit: 255
    t.integer  "fab10_cost",                        default: 50000
    t.datetime "fab10_claimed_at"
    t.integer  "fab10_attendee_id"
    t.boolean  "fab10_email_sent"
    t.string   "vimeo",                 limit: 255
    t.string   "flickr",                limit: 255
    t.string   "youtube",               limit: 255
    t.string   "drive",                 limit: 255
    t.string   "dropbox",               limit: 255
    t.string   "twitter",               limit: 255
    t.string   "facebook",              limit: 255
    t.string   "web",                   limit: 255
    t.string   "github",                limit: 255
    t.string   "bitbucket",             limit: 255
    t.string   "googleplus",            limit: 255
    t.string   "instagram",             limit: 255
    t.boolean  "agree_policy_terms",                default: false
    t.string   "avatar_uid",            limit: 255
    t.string   "avatar_name",           limit: 255
    t.string   "discourse_id",          limit: 255
    t.string   "slug",                  limit: 255
    t.string   "email_fallback"
  end

  add_index "users", ["fab10_coupon_code"], name: "index_users_on_fab10_coupon_code", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
