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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130106194714) do

  create_table "campaigns", :force => true do |t|
    t.integer  "user_id"
    t.string   "category"
    t.string   "type_of_incorporation"
    t.string   "group_name"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "one_sentence"
    t.string   "long_description"
    t.string   "youtube_link"
    t.string   "vimeo_link"
    t.string   "youtube_video_id"
    t.string   "vimeo_video_id"
    t.decimal  "request"
    t.date     "end_date"
    t.boolean  "active",                :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "campaigns", ["active"], :name => "index_campaigns_on_active"
  add_index "campaigns", ["category"], :name => "index_campaigns_on_category"
  add_index "campaigns", ["city"], :name => "index_campaigns_on_city"
  add_index "campaigns", ["end_date"], :name => "index_campaigns_on_end_date"
  add_index "campaigns", ["group_name"], :name => "index_campaigns_on_group_name"
  add_index "campaigns", ["name"], :name => "index_campaigns_on_name"
  add_index "campaigns", ["state"], :name => "index_campaigns_on_state"
  add_index "campaigns", ["type_of_incorporation"], :name => "index_campaigns_on_type_of_incorporation"

  create_table "gifts", :force => true do |t|
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "description"
    t.integer  "stock"
    t.decimal  "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "gifts", ["price"], :name => "index_gifts_on_price"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "transactions", :force => true do |t|
    t.integer  "funder_id"
    t.integer  "funded_id"
    t.integer  "gift_id"
    t.decimal  "amount"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "transactions", ["funded_id"], :name => "index_transactions_on_funded_id"
  add_index "transactions", ["funder_id", "funded_id"], :name => "index_transactions_on_funder_id_and_funded_id"
  add_index "transactions", ["funder_id"], :name => "index_transactions_on_funder_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
