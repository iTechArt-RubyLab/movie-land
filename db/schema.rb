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

ActiveRecord::Schema.define(version: 2022_03_19_074127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actor_roles", force: :cascade do |t|
    t.string "role_name"
    t.bigint "actor_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["actor_id"], name: "index_actor_roles_on_actor_id"
    t.index ["movie_id"], name: "index_actor_roles_on_movie_id"
    t.index ["role_name", "movie_id", "actor_id"], name: "index_actor_roles_on_role_name_and_movie_id_and_actor_id", unique: true
  end

  create_table "awards", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_awards_on_country_id"
    t.index ["name"], name: "index_awards_on_name", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "award_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["award_id"], name: "index_categories_on_award_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "companies_movies", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "movie_id", null: false
    t.index ["company_id", "movie_id"], name: "index_companies_movies_on_company_id_and_movie_id", unique: true
    t.index ["movie_id", "company_id"], name: "index_companies_movies_on_movie_id_and_company_id", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "countries_movies", id: false, force: :cascade do |t|
    t.bigint "country_id", null: false
    t.bigint "movie_id", null: false
    t.index ["country_id", "movie_id"], name: "index_countries_movies_on_country_id_and_movie_id", unique: true
    t.index ["movie_id", "country_id"], name: "index_countries_movies_on_movie_id_and_country_id", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.index ["genre_id", "movie_id"], name: "index_genres_movies_on_genre_id_and_movie_id", unique: true
    t.index ["movie_id", "genre_id"], name: "index_genres_movies_on_movie_id_and_genre_id", unique: true
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "languages_movies", id: false, force: :cascade do |t|
    t.bigint "language_id", null: false
    t.bigint "movie_id", null: false
    t.index ["language_id", "movie_id"], name: "index_languages_movies_on_language_id_and_movie_id", unique: true
    t.index ["movie_id", "language_id"], name: "index_languages_movies_on_movie_id_and_language_id", unique: true
  end

  create_table "movie_awards", force: :cascade do |t|
    t.integer "delivery_year"
    t.integer "nomination_type"
    t.bigint "movie_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_movie_awards_on_category_id"
    t.index ["movie_id"], name: "index_movie_awards_on_movie_id"
  end

  create_table "movie_awards_people", id: false, force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "movie_award_id", null: false
    t.index ["movie_award_id", "person_id"], name: "index_movie_awards_people_on_movie_award_id_and_person_id", unique: true
    t.index ["person_id", "movie_award_id"], name: "index_movie_awards_people_on_person_id_and_movie_award_id", unique: true
  end

  create_table "movie_staffs", force: :cascade do |t|
    t.integer "staff_type"
    t.bigint "movie_id", null: false
    t.bigint "staff_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_staffs_on_movie_id"
    t.index ["staff_id"], name: "index_movie_staffs_on_staff_id"
    t.index ["staff_type", "movie_id", "staff_id"], name: "index_movie_staffs_on_staff_type_and_movie_id_and_staff_id", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "tagline"
    t.string "trailer"
    t.date "release_date"
    t.integer "age_limit"
    t.bigint "budget"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "poster"
    t.string "images", default: [], array: true
    t.integer "total_score", default: 0
    t.integer "number_of_ratings", default: 0
    t.index ["name"], name: "index_movies_on_name", unique: true
  end

  create_table "movies_tags", id: false, force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "tag_id", null: false
    t.index ["movie_id", "tag_id"], name: "index_movies_tags_on_movie_id_and_tag_id", unique: true
    t.index ["tag_id", "movie_id"], name: "index_movies_tags_on_tag_id_and_movie_id", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.date "birthday"
    t.date "deathday"
    t.bigint "country_id"
    t.boolean "married"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "biography"
    t.index ["country_id"], name: "index_people_on_country_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.boolean "can_lock_user"
    t.boolean "can_edit_role"
    t.boolean "can_set_role"
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "can_read_entities"
    t.boolean "can_edit_entities"
    t.boolean "can_edit_permission"
    t.boolean "can_read_user"
    t.boolean "can_read_movie"
    t.boolean "can_edit_movie"
    t.boolean "can_read_person"
    t.boolean "can_edit_person"
    t.boolean "can_give_rating"
    t.boolean "can_read_rating"
    t.boolean "can_leave_comment"
    t.boolean "can_read_award"
    t.boolean "can_edit_award"
    t.boolean "can_read_view_list"
    t.boolean "can_edit_view_list"
    t.boolean "can_export_to_csv"
    t.boolean "can_use_search"
    t.index ["role_id"], name: "index_permissions_on_role_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating"
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_ratings_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_ratings_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "email"
    t.string "name"
    t.string "surname"
    t.string "username"
    t.date "birthday"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "view_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "watching_status"
    t.index ["movie_id"], name: "index_view_lists_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_view_lists_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_view_lists_on_user_id"
  end

  add_foreign_key "actor_roles", "movies"
  add_foreign_key "actor_roles", "people", column: "actor_id"
  add_foreign_key "awards", "countries"
  add_foreign_key "categories", "awards"
  add_foreign_key "comments", "users"
  add_foreign_key "movie_awards", "categories"
  add_foreign_key "movie_awards", "movies"
  add_foreign_key "movie_staffs", "movies"
  add_foreign_key "movie_staffs", "people", column: "staff_id"
  add_foreign_key "people", "countries"
  add_foreign_key "permissions", "roles"
  add_foreign_key "ratings", "movies"
  add_foreign_key "ratings", "users"
  add_foreign_key "users", "roles"
  add_foreign_key "view_lists", "movies"
  add_foreign_key "view_lists", "users"
end
