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

ActiveRecord::Schema.define(:version => 20120625010605) do

  create_table "feature_box_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "feature_box_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "suggestion_id"
    t.text     "text",          :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "feature_box_comments", ["suggestion_id"], :name => "index_feature_box_comments_on_suggestion_id"
  add_index "feature_box_comments", ["user_id"], :name => "index_feature_box_comments_on_user_id"

  create_table "feature_box_suggestions", :force => true do |t|
    t.string   "title",                              :null => false
    t.text     "description",                        :null => false
    t.string   "status",      :default => "default"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "feature_box_suggestions", ["category_id"], :name => "index_feature_box_suggestions_on_category_id"
  add_index "feature_box_suggestions", ["user_id"], :name => "index_feature_box_suggestions_on_user_id"

  create_table "feature_box_users", :force => true do |t|
    t.string   "name",                                      :null => false
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "feature_box_users", ["email"], :name => "index_feature_box_users_on_email", :unique => true
  add_index "feature_box_users", ["reset_password_token"], :name => "index_feature_box_users_on_reset_password_token", :unique => true

  create_table "feature_box_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "suggestion_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "feature_box_votes", ["suggestion_id"], :name => "index_feature_box_votes_on_suggestion_id"
  add_index "feature_box_votes", ["user_id"], :name => "index_feature_box_votes_on_user_id"

end
