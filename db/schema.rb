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

ActiveRecord::Schema.define(:version => 20120321101107) do

  create_table "blocks", :force => true do |t|
    t.integer  "state_id"
    t.integer  "division_id"
    t.integer  "district_id"
    t.string   "name"
    t.text     "description"
    t.text     "short_code"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", :force => true do |t|
    t.integer  "state_id"
    t.integer  "division_id"
    t.string   "name"
    t.text     "description"
    t.text     "short_code"
    t.boolean  "vle_check"
    t.integer  "dis_number",  :default => 0
    t.integer  "status",      :default => 0
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divisions", :force => true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.text     "description"
    t.string   "short_code"
    t.integer  "status",      :default => 0
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panchayats", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "state_id"
    t.integer  "division_id"
    t.integer  "district_id"
    t.integer  "block_id"
    t.boolean  "status",      :default => true
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "division_id"
    t.integer  "district_id"
    t.integer  "block_id"
    t.string   "panchayat"
    t.string   "csc_code"
    t.string   "vle_code"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "father_name"
    t.string   "gender"
    t.date     "dob"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "place"
    t.string   "pin"
    t.string   "mobile_number"
    t.string   "phone_number"
    t.string   "verification_code"
    t.string   "verification_date"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.boolean  "approved",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
