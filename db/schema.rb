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

ActiveRecord::Schema.define(version: 2019_08_11_024244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodations", force: :cascade do |t|
    t.string "name", null: false
    t.string "accommodation_type", limit: 10, null: false
    t.string "address"
    t.datetime "check_in_at"
    t.datetime "check_out_at"
    t.integer "amount_in_cents"
    t.string "amount_currency", limit: 3, default: "USD"
    t.string "notes"
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["trip_id"], name: "index_accommodations_on_trip_id"
  end

  create_table "car_rentals", force: :cascade do |t|
    t.string "company", null: false
    t.string "reservation_number"
    t.string "pick_up_address"
    t.datetime "pick_up_at"
    t.string "drop_off_address"
    t.datetime "drop_off_at"
    t.integer "amount_in_cents"
    t.string "amount_currency", limit: 3, default: "USD"
    t.string "notes"
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["trip_id"], name: "index_car_rentals_on_trip_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "airline", null: false
    t.integer "flight_number", limit: 2
    t.string "depart_airport", limit: 3
    t.datetime "depart_at"
    t.string "arrive_airport", limit: 3
    t.datetime "arrive_at"
    t.integer "amount_in_cents"
    t.string "amount_currency", limit: 3, default: "USD"
    t.string "notes"
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["trip_id"], name: "index_flights_on_trip_id"
  end

  create_table "points_of_interest", force: :cascade do |t|
    t.string "name", null: false
    t.date "visit_date", null: false
    t.string "address"
    t.integer "amount_in_cents"
    t.string "amount_currency", limit: 3, default: "USD"
    t.string "notes"
    t.integer "order", limit: 2, null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["trip_id"], name: "index_points_of_interest_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "budget_in_cents"
    t.string "budget_currency", limit: 3, default: "USD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "user_trips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "trip_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["trip_id"], name: "index_user_trips_on_trip_id"
    t.index ["user_id"], name: "index_user_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_foreign_key "accommodations", "trips"
  add_foreign_key "car_rentals", "trips"
  add_foreign_key "flights", "trips"
  add_foreign_key "points_of_interest", "trips"
  add_foreign_key "user_trips", "trips"
  add_foreign_key "user_trips", "users"
end
