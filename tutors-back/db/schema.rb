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

ActiveRecord::Schema.define(version: 20210319092448) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_user_type"
    t.integer "account_user_id"
  end

  create_table "appointments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.datetime "startDateTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student"
    t.integer "teacher"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.text "text"
    t.datetime "sentDateTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.string "photo"
    t.bigint "appointments_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.index ["appointments_id"], name: "index_students_on_appointments_id"
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.string "photo"
    t.bigint "appointments_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.index ["appointments_id"], name: "index_teachers_on_appointments_id"
  end

  add_foreign_key "students", "appointments", column: "appointments_id"
  add_foreign_key "teachers", "appointments", column: "appointments_id"
end
