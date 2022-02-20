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

ActiveRecord::Schema.define(version: 2022_02_20_145356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies_movies", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "movie_id", null: false
    t.index ["company_id", "movie_id"], name: "index_companies_movies_on_company_id_and_movie_id"
    t.index ["movie_id", "company_id"], name: "index_companies_movies_on_movie_id_and_company_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries_movies", id: false, force: :cascade do |t|
    t.bigint "country_id", null: false
    t.bigint "movie_id", null: false
    t.index ["country_id", "movie_id"], name: "index_countries_movies_on_country_id_and_movie_id"
    t.index ["movie_id", "country_id"], name: "index_countries_movies_on_movie_id_and_country_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres_movies", id: false, force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.index ["genre_id", "movie_id"], name: "index_genres_movies_on_genre_id_and_movie_id"
    t.index ["movie_id", "genre_id"], name: "index_genres_movies_on_movie_id_and_genre_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "languages_movies", id: false, force: :cascade do |t|
    t.bigint "language_id", null: false
    t.bigint "movie_id", null: false
    t.index ["language_id", "movie_id"], name: "index_languages_movies_on_language_id_and_movie_id"
    t.index ["movie_id", "language_id"], name: "index_languages_movies_on_movie_id_and_language_id"
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
  end

end
