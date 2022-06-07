# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_26_124346) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("name", null: false)
    t.text("body")
    t.string("record_type", null: false)
    t.uuid("record_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true)
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("name", null: false)
    t.string("record_type", null: false)
    t.uuid("record_id", null: false)
    t.uuid("blob_id", null: false)
    t.datetime("created_at", null: false)
    t.index(["blob_id"], name: "index_active_storage_attachments_on_blob_id")
    t.index(["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness",
      unique: true)
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("key", null: false)
    t.string("filename", null: false)
    t.string("content_type")
    t.text("metadata")
    t.string("service_name", null: false)
    t.bigint("byte_size", null: false)
    t.string("checksum")
    t.datetime("created_at", null: false)
    t.index(["key"], name: "index_active_storage_blobs_on_key", unique: true)
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid("blob_id", null: false)
    t.string("variation_digest", null: false)
    t.index(["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true)
  end

  create_table "assessments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("input", null: false)
    t.uuid("exercise_id", null: false)
    t.integer("leeway", default: 0, null: false)
    t.integer("timeout", default: 10, null: false)
    t.boolean("hidden", default: false, null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["exercise_id"], name: "index_assessments_on_exercise_id")
  end

  create_table "challenges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("title", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.uuid("constraint_id", null: false)
    t.index(["constraint_id"], name: "index_challenges_on_constraint_id")
  end

  create_table "constraints", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("title")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
  end

  create_table "exercises", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("title", null: false)
    t.integer("position", null: false)
    t.integer("unlock_criteria", default: 0, null: false)
    t.uuid("level_id", null: false)
    t.string("implementation", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["level_id"], name: "index_exercises_on_level_id")
  end

  create_table "invitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("code")
    t.uuid("user_id")
    t.uuid("challenge_id", null: false)
    t.uuid("issuer_id")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["challenge_id"], name: "index_invitations_on_challenge_id")
    t.index(["issuer_id"], name: "index_invitations_on_issuer_id")
    t.index(["user_id"], name: "index_invitations_on_user_id")
  end

  create_table "levels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("title", null: false)
    t.uuid("challenge_id", null: false)
    t.integer("position", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["challenge_id"], name: "index_levels_on_challenge_id")
  end

  create_table "results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean("passed", null: false)
    t.string("answer")
    t.float("time_spent")
    t.string("state", default: "pending", null: false)
    t.uuid("submission_id", null: false)
    t.uuid("assessment_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["assessment_id"], name: "index_results_on_assessment_id")
    t.index(["submission_id"], name: "index_results_on_submission_id")
  end

  create_table "submissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("implementation")
    t.uuid("user_id", null: false)
    t.uuid("exercise_id", null: false)
    t.float("score", default: 0.0)
    t.boolean("passed", default: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["exercise_id"], name: "index_submissions_on_exercise_id")
    t.index(["user_id"], name: "index_submissions_on_user_id")
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string("email", default: "", null: false)
    t.string("encrypted_password", default: "", null: false)
    t.string("reset_password_token")
    t.datetime("reset_password_sent_at")
    t.datetime("remember_created_at")
    t.integer("sign_in_count", default: 0, null: false)
    t.datetime("current_sign_in_at")
    t.datetime("last_sign_in_at")
    t.string("current_sign_in_ip")
    t.string("last_sign_in_ip")
    t.string("confirmation_token")
    t.datetime("confirmed_at")
    t.datetime("confirmation_sent_at")
    t.string("unconfirmed_email")
    t.integer("failed_attempts", default: 0, null: false)
    t.string("unlock_token")
    t.datetime("locked_at")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.string("family_name")
    t.string("given_name")
    t.date("date_of_birth")
    t.string("external_id")
    t.string("external_id_source")
    t.boolean("admin", default: false)
    t.boolean("anonymous_on_leaderboards", default: false)
    t.string("display_name")
    t.boolean("open_for_offers", default: false)
    t.boolean("onboarded", default: false)
    t.string("linked_in_handle")
    t.string("github_handle")
    t.string("phone_number")
    t.index(["confirmation_token"], name: "index_users_on_confirmation_token", unique: true)
    t.index(["email"], name: "index_users_on_email", unique: true)
    t.index(["reset_password_token"], name: "index_users_on_reset_password_token", unique: true)
    t.index(["unlock_token"], name: "index_users_on_unlock_token", unique: true)
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assessments", "exercises"
  add_foreign_key "challenges", "constraints"
  add_foreign_key "exercises", "levels"
  add_foreign_key "invitations", "challenges"
  add_foreign_key "invitations", "users"
  add_foreign_key "invitations", "users", column: "issuer_id"
  add_foreign_key "levels", "challenges"
  add_foreign_key "results", "assessments"
  add_foreign_key "results", "submissions"
  add_foreign_key "submissions", "exercises"
  add_foreign_key "submissions", "users"
end
