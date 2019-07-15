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

ActiveRecord::Schema.define(version: 2019_07_13_030745) do

  create_table "bill_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type_detail"
    t.integer "count"
    t.float "price"
    t.bigint "bill_id"
    t.bigint "product_id"
    t.bigint "combo_id"
    t.index ["bill_id"], name: "index_bill_details_on_bill_id"
    t.index ["combo_id"], name: "index_bill_details_on_combo_id"
    t.index ["product_id"], name: "index_bill_details_on_product_id"
  end

  create_table "bills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "table_id"
    t.index ["table_id"], name: "index_bills_on_table_id"
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "combos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.float "price"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "image"
    t.integer "status"
    t.bigint "combo_id"
    t.index ["combo_id"], name: "index_products_on_combo_id"
  end

  create_table "tables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "number"
    t.text "description"
    t.integer "amount_chair"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "phone"
    t.string "address"
    t.string "name"
    t.string "username"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "bill_details", "bills"
  add_foreign_key "bill_details", "combos"
  add_foreign_key "bill_details", "products"
  add_foreign_key "bills", "tables"
  add_foreign_key "bills", "users"
  add_foreign_key "products", "combos"
end
