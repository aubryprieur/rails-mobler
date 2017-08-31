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

ActiveRecord::Schema.define(version: 20170831150021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.bigint "wishlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
    t.index ["wishlist_id"], name: "index_donations_on_wishlist_id"
  end

  create_table "furnitures", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "photo"
    t.integer "height"
    t.integer "width"
    t.integer "length"
    t.float "price"
    t.string "url"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "sku"
    t.index ["category_id"], name: "index_furnitures_on_category_id"
  end

  create_table "furnitures_wishlists", force: :cascade do |t|
    t.bigint "wishlist_id"
    t.bigint "furniture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["furniture_id"], name: "index_furnitures_wishlists_on_furniture_id"
    t.index ["wishlist_id"], name: "index_furnitures_wishlists_on_wishlist_id"
  end

  create_table "guest_wishlists", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "wishlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["user_id"], name: "index_guest_wishlists_on_user_id"
    t.index ["wishlist_id"], name: "index_guest_wishlists_on_wishlist_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.json "payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "furniture_sku"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "furnitures_wishlist_id"
    t.index ["furnitures_wishlist_id"], name: "index_reviews_on_furnitures_wishlist_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "photo"
    t.boolean "admin"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "token"
    t.datetime "token_expiry"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "donations", "users"
  add_foreign_key "donations", "wishlists"
  add_foreign_key "furnitures", "categories"
  add_foreign_key "furnitures_wishlists", "furnitures"
  add_foreign_key "furnitures_wishlists", "wishlists"
  add_foreign_key "guest_wishlists", "users"
  add_foreign_key "guest_wishlists", "wishlists"
  add_foreign_key "reviews", "users"
  add_foreign_key "wishlists", "users"
end
