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

ActiveRecord::Schema.define(:version => 20131130231853) do

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "original_url"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "image_url"
    t.string   "content_type"
    t.integer  "zencoder_output_id"
    t.boolean  "zencoder_processed", :default => false
    t.string   "thumbnail_url"
    t.integer  "width"
    t.integer  "height"
    t.integer  "duration"
    t.string   "original_file_name"
    t.string   "processed_url"
    t.string   "thumb_url"
    t.text     "html"
    t.string   "author_url"
    t.integer  "thumb_width"
    t.integer  "thumb_height"
    t.string   "author_name"
    t.string   "oembed_type"
  end

end
