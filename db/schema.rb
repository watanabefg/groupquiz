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

ActiveRecord::Schema.define(:version => 20120524151353) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "belongs_to_groups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "belongs_to_groups", ["group_id"], :name => "index_belongs_to_groups_on_group_id"
  add_index "belongs_to_groups", ["user_id"], :name => "index_belongs_to_groups_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "group_category_radio"
    t.decimal  "price"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "quiz_title"
    t.text     "quiz_contents"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "category_id"
    t.text     "correct_answer_message"
    t.text     "not_correct_answer_message"
    t.integer  "user_id"
    t.text     "quiz_answer1"
    t.text     "quiz_answer2"
    t.text     "quiz_answer3"
    t.text     "quiz_answer4"
    t.integer  "quiz_answer_radio"
    t.integer  "group_id"
    t.text     "correct_answer_message2"
    t.text     "correct_answer_message3"
    t.text     "correct_answer_message4"
  end

  create_table "sexes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.date     "birthday"
    t.integer  "sex_id"
    t.string   "email_address"
    t.string   "password"
    t.date     "registration_date"
    t.date     "term_of_validity"
    t.integer  "Account_information_flag"
    t.integer  "possession_medals"
    t.datetime "last_login_time"
    t.integer  "number_of_login"
  end

end
