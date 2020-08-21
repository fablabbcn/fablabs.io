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

ActiveRecord::Schema.define(version: 2020_08_21_001528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "academics", force: :cascade do |t|
    t.integer "user_id"
    t.integer "lab_id"
    t.integer "started_in"
    t.string "type", limit: 255
    t.integer "approver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore "meta"
    t.index ["approver_id"], name: "index_academics_on_approver_id"
    t.index ["user_id", "lab_id"], name: "index_academics_on_user_id_and_lab_id", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.integer "creator_id"
    t.string "action", limit: 255
    t.integer "trackable_id"
    t.string "trackable_type", limit: 255
    t.datetime "created_at"
    t.integer "actor_id"
    t.index ["actor_id"], name: "index_activities_on_actor_id"
    t.index ["creator_id"], name: "index_activities_on_creator_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "admin_applications", force: :cascade do |t|
    t.integer "applicant_id"
    t.integer "lab_id"
    t.text "notes"
    t.string "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["applicant_id", "lab_id"], name: "index_admin_applications_on_applicant_id_and_lab_id"
  end

  create_table "approval_workflow_logs", force: :cascade do |t|
    t.string "lab_id"
    t.string "user_id"
    t.string "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lab_id"], name: "index_approval_workflow_logs_on_lab_id"
    t.index ["user_id"], name: "index_approval_workflow_logs_on_user_id"
    t.index ["workflow_state"], name: "index_approval_workflow_logs_on_workflow_state"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.string "workflow_state", limit: 255
    t.integer "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_id"], name: "index_brands_on_creator_id"
  end

  create_table "collaborations", force: :cascade do |t|
    t.integer "project_id"
    t.integer "collaborator_id"
    t.datetime "last_collaboration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["collaborator_id"], name: "index_collaborations_on_collaborator_id"
    t.index ["project_id"], name: "index_collaborations_on_project_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "author_id"
    t.string "ancestry", limit: 255
    t.integer "commentable_id"
    t.string "commentable_type", limit: 255
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ancestry"], name: "index_comments_on_ancestry"
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  end

  create_table "contributions", force: :cascade do |t|
    t.integer "project_id"
    t.integer "contributor_id"
    t.datetime "last_contribution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contributor_id"], name: "index_contributions_on_contributor_id"
    t.index ["project_id"], name: "index_contributions_on_project_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer "user_id"
    t.string "description", limit: 255
    t.string "code", limit: 255, null: false
    t.integer "value"
    t.datetime "redeemed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "body"
    t.integer "discussable_id"
    t.string "discussable_type", limit: 255
    t.integer "creator_id"
    t.string "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_id"], name: "index_discussions_on_creator_id"
    t.index ["discussable_id", "discussable_type"], name: "index_discussions_on_discussable_id_and_discussable_type"
  end

  create_table "documents", force: :cascade do |t|
    t.string "type", limit: 255
    t.string "title", limit: 255
    t.text "description"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "documentable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "documentable_type", limit: 255
    t.string "photo_uid", limit: 255
    t.string "photo_name", limit: 255
    t.index ["documentable_id"], name: "index_documents_on_documentable_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "user_id"
    t.integer "lab_id"
    t.integer "ordinal"
    t.string "job_title", limit: 255
    t.string "email", limit: 255
    t.string "phone", limit: 255
    t.text "description"
    t.date "started_on"
    t.date "finished_on"
    t.string "workflow_state", limit: 255
    t.integer "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_id"], name: "index_employees_on_creator_id"
    t.index ["lab_id"], name: "index_employees_on_lab_id"
    t.index ["ordinal"], name: "index_employees_on_ordinal"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "type", limit: 255
    t.string "name", limit: 255
    t.text "description"
    t.integer "lab_id"
    t.integer "creator_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "tags"
    t.index ["creator_id"], name: "index_events_on_creator_id"
    t.index ["lab_id"], name: "index_events_on_lab_id"
    t.index ["tags"], name: "index_events_on_tags"
  end

  create_table "facilities", force: :cascade do |t|
    t.integer "lab_id"
    t.integer "thing_id"
    t.text "notes"
    t.integer "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_id"], name: "index_facilities_on_creator_id"
    t.index ["lab_id", "thing_id"], name: "index_facilities_on_lab_id_and_thing_id", unique: true
  end

  create_table "favourites", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_id"], name: "index_favourites_on_project_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "featured_images", force: :cascade do |t|
    t.string "src", limit: 255
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "url", limit: 255
    t.string "workflow_state", limit: 255
    t.integer "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_id"], name: "index_featured_images_on_creator_id"
  end

  create_table "grades", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.integer "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_id"], name: "index_grades_on_project_id"
    t.index ["user_id"], name: "index_grades_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "apply_url"
    t.boolean "is_featured"
    t.boolean "is_verified"
    t.bigint "user_id"
    t.decimal "min_salary"
    t.decimal "max_salary"
    t.string "country_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "lab_organizations", force: :cascade do |t|
    t.integer "lab_id"
    t.integer "organization_id"
    t.string "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lab_id"], name: "index_lab_organizations_on_lab_id"
    t.index ["organization_id"], name: "index_lab_organizations_on_organization_id"
  end

  create_table "labs", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "slug", limit: 255
    t.text "description"
    t.string "ancestry", limit: 255
    t.integer "creator_id"
    t.string "workflow_state", limit: 255
    t.integer "capabilities"
    t.string "time_zone", limit: 255
    t.string "phone", limit: 255
    t.string "email", limit: 255
    t.string "address_1", limit: 255
    t.string "address_2", limit: 255
    t.string "city", limit: 255
    t.string "county", limit: 255
    t.string "postal_code", limit: 255
    t.string "country_code", limit: 255
    t.string "subregion", limit: 255
    t.string "region", limit: 255
    t.float "latitude"
    t.float "longitude"
    t.integer "zoom"
    t.text "address_notes"
    t.text "reverse_geocoded_address"
    t.integer "kind"
    t.text "application_notes"
    t.text "tools_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "blurb", limit: 255
    t.integer "referee_id"
    t.boolean "network", default: false
    t.boolean "programs", default: false
    t.boolean "tools", default: false
    t.boolean "charter", default: false
    t.boolean "public", default: false
    t.string "discourse_id", limit: 255
    t.text "discourse_errors"
    t.boolean "is_referee", default: false
    t.string "avatar_uid", limit: 255
    t.string "avatar_name", limit: 255
    t.string "header_uid", limit: 255
    t.string "header_name", limit: 255
    t.string "activity_status", limit: 255
    t.date "activity_start_at"
    t.date "activity_inaugurated_at"
    t.date "activity_closed_at"
    t.text "improve_approval_application"
    t.index ["creator_id"], name: "index_labs_on_creator_id"
    t.index ["referee_id"], name: "index_labs_on_referee_id"
    t.index ["slug"], name: "index_labs_on_slug", unique: true
  end

  create_table "links", force: :cascade do |t|
    t.integer "linkable_id"
    t.string "linkable_type", limit: 255
    t.integer "ordinal"
    t.string "url", limit: 255
    t.string "description", limit: 255
    t.string "workflow_state", limit: 255
    t.integer "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["creator_id"], name: "index_links_on_creator_id"
    t.index ["linkable_id", "linkable_type", "ordinal"], name: "index_links_on_linkable_id_and_linkable_type_and_ordinal"
  end

  create_table "machineries", force: :cascade do |t|
    t.integer "project_id"
    t.integer "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["device_id"], name: "index_machineries_on_device_id"
    t.index ["project_id"], name: "index_machineries_on_project_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", limit: 255, null: false
    t.integer "expires_in", null: false
    t.string "redirect_uri", limit: 2048, null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", limit: 255
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id", null: false
    t.string "token", limit: 255, null: false
    t.string "refresh_token", limit: 255
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes", limit: 255
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "uid", limit: 255, null: false
    t.string "secret", limit: 255, null: false
    t.string "redirect_uri", limit: 2048, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "scopes", default: "", null: false
    t.integer "owner_id"
    t.string "owner_type"
    t.boolean "confidential", default: true, null: false
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.integer "creator_id"
    t.string "slug", limit: 255
    t.string "kind", limit: 255
    t.string "blurb", limit: 255
    t.string "phone", limit: 255
    t.string "email", limit: 255
    t.text "application_notes"
    t.string "discourse_id", limit: 255
    t.string "discourse_errors", limit: 255
    t.string "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "geojson"
    t.float "latitude"
    t.float "longitude"
    t.integer "zoom"
    t.string "address_1", limit: 255
    t.string "address_2", limit: 255
    t.string "city", limit: 255
    t.string "county", limit: 255
    t.string "postal_code", limit: 255
    t.string "country_code", limit: 255
    t.string "subregion", limit: 255
    t.string "region", limit: 255
    t.text "address_notes"
    t.text "reverse_geocoded_address"
    t.string "avatar_uid", limit: 255
    t.string "avatar_name", limit: 255
    t.string "header_uid", limit: 255
    t.string "header_name", limit: 255
    t.integer "order"
    t.index ["order"], name: "index_organizations_on_order"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "pages", force: :cascade do |t|
    t.string "title", limit: 255
    t.string "slug", limit: 255
    t.text "content"
    t.integer "position", default: 0
    t.boolean "published", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["slug"], name: "index_pages_on_slug"
  end

  create_table "projects", force: :cascade do |t|
    t.string "type", limit: 255
    t.string "title", limit: 255
    t.text "description"
    t.integer "lab_id"
    t.integer "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "status", limit: 255
    t.string "version", limit: 255
    t.text "faq"
    t.text "scope"
    t.text "community"
    t.text "lookingfor"
    t.string "cover", limit: 255
    t.string "discourse_id", limit: 255
    t.text "discourse_errors"
    t.string "slug", limit: 255
    t.integer "visibility", default: 1
    t.index ["lab_id"], name: "index_projects_on_lab_id"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
    t.index ["visibility"], name: "index_projects_on_visibility"
  end

  create_table "recoveries", force: :cascade do |t|
    t.integer "user_id"
    t.string "key", limit: 255
    t.string "ip", limit: 255
    t.string "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_recoveries_on_user_id"
  end

  create_table "referee_approval_processes", force: :cascade do |t|
    t.integer "referred_lab_id"
    t.integer "referee_lab_id"
    t.boolean "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["referee_lab_id"], name: "index_referee_approval_processes_on_referee_lab_id"
    t.index ["referred_lab_id"], name: "index_referee_approval_processes_on_referred_lab_id"
  end

  create_table "role_applications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "lab_id"
    t.string "workflow_state", limit: 255
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "lab_id"], name: "index_role_applications_on_user_id_and_lab_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "resource_id"
    t.string "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "steps", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.integer "position"
    t.integer "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_id"], name: "index_steps_on_project_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 255
    t.integer "tagger_id"
    t.string "tagger_type", limit: 255
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "things", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "brand_id"
    t.text "description"
    t.string "workflow_state", limit: 255
    t.string "ancestry", limit: 255
    t.integer "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "type", limit: 255
    t.boolean "inventory_item", default: false
    t.string "discourse_id", limit: 255
    t.text "discourse_errors"
    t.string "photo_uid", limit: 255
    t.string "photo_name", limit: 255
    t.string "slug", limit: 255
    t.index ["brand_id"], name: "index_things_on_brand_id"
    t.index ["creator_id"], name: "index_things_on_creator_id"
    t.index ["id", "type", "inventory_item"], name: "index_things_on_id_and_type_and_inventory_item"
    t.index ["slug"], name: "index_things_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "workflow_state", limit: 255
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255
    t.string "username", limit: 255
    t.string "password_digest", limit: 255
    t.string "phone", limit: 255
    t.string "city", limit: 255
    t.string "country_code", limit: 255
    t.float "latitude"
    t.float "longitude"
    t.string "url", limit: 255
    t.date "dob"
    t.text "bio"
    t.string "locale", limit: 255
    t.string "time_zone", limit: 255
    t.boolean "use_metric", default: true
    t.string "email_validation_hash", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "fab10_coupon_code", limit: 255
    t.integer "fab10_cost", default: 50000
    t.datetime "fab10_claimed_at"
    t.integer "fab10_attendee_id"
    t.boolean "fab10_email_sent"
    t.string "vimeo", limit: 255
    t.string "flickr", limit: 255
    t.string "youtube", limit: 255
    t.string "drive", limit: 255
    t.string "dropbox", limit: 255
    t.string "twitter", limit: 255
    t.string "facebook", limit: 255
    t.string "web", limit: 255
    t.string "github", limit: 255
    t.string "bitbucket", limit: 255
    t.string "googleplus", limit: 255
    t.string "instagram", limit: 255
    t.boolean "agree_policy_terms", default: false
    t.string "avatar_uid", limit: 255
    t.string "avatar_name", limit: 255
    t.string "discourse_id", limit: 255
    t.string "slug", limit: 255
    t.string "email_fallback"
    t.index ["fab10_coupon_code"], name: "index_users_on_fab10_coupon_code", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "jobs", "users"
end
