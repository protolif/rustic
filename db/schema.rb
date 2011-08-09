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

ActiveRecord::Schema.define(:version => 20110809070709) do

  create_table "computers", :force => true do |t|
    t.string   "make"
    t.string   "model"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "serial"
    t.boolean  "charger"
    t.string   "cpu"
    t.string   "ram"
    t.datetime "checked_in"
    t.datetime "checked_out"
    t.string   "form_factor"
  end

  add_index "computers", ["created_at"], :name => "index_computers_on_created_at"
  add_index "computers", ["user_id"], :name => "index_computers_on_user_id"

  create_table "tickets", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "computer_id"
    t.integer  "technician_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "issue"
    t.string   "status"
  end

  add_index "tickets", ["computer_id"], :name => "index_tickets_on_computer_id"
  add_index "tickets", ["customer_id"], :name => "index_tickets_on_customer_id"
  add_index "tickets", ["technician_id"], :name => "index_tickets_on_technician_id"

  create_table "users", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.string   "tel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
