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

ActiveRecord::Schema.define(:version => 20120219110301) do

  create_table "audits", :force => true do |t|
    t.datetime "date_completed"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "books"
  end

  add_index "audits", ["date_completed"], :name => "index_audits_on_date_completed"

  create_table "authors", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authors", ["first", "last"], :name => "index_authors_on_first_and_last", :unique => true
  add_index "authors", ["first"], :name => "index_authors_on_first"
  add_index "authors", ["last"], :name => "index_authors_on_last"

  create_table "books", :force => true do |t|
    t.string   "title"
    t.integer  "pub_year"
    t.string   "genre"
    t.string   "age_group"
    t.integer  "num_pages"
    t.string   "series_title"
    t.integer  "series_number"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.integer  "checkout_count", :default => 0
    t.string   "language"
    t.integer  "num_copies_nep"
    t.integer  "num_copies_emd"
  end

  add_index "books", ["checkout_count"], :name => "index_books_on_checkout_count"
  add_index "books", ["language"], :name => "index_books_on_language"
  add_index "books", ["num_copies_emd"], :name => "index_books_on_num_copies_emd"
  add_index "books", ["num_copies_nep"], :name => "index_books_on_num_copies_nep"

  create_table "checkout_items", :force => true do |t|
    t.integer  "book_id"
    t.boolean  "status"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkout_items", ["book_id"], :name => "index_checkout_items_on_book_id"
  add_index "checkout_items", ["status"], :name => "index_checkout_items_on_status"

  create_table "class_records", :force => true do |t|
    t.integer  "grade_id"
    t.datetime "arrival"
    t.datetime "departure"
    t.boolean  "teacher"
    t.integer  "attendance"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "class_records", ["attendance"], :name => "index_class_records_on_attendance"
  add_index "class_records", ["grade_id"], :name => "index_class_records_on_grade_id"
  add_index "class_records", ["teacher"], :name => "index_class_records_on_teacher"

  create_table "grades", :force => true do |t|
    t.integer  "year"
    t.integer  "number_students"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "grades", ["year"], :name => "index_grades_on_year"

  create_table "subject_tags", :force => true do |t|
    t.integer  "book_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subject_tags", ["book_id", "subject_id"], :name => "index_subject_tags_on_book_id_and_subject_id", :unique => true
  add_index "subject_tags", ["book_id"], :name => "index_subject_tags_on_book_id"
  add_index "subject_tags", ["subject_id"], :name => "index_subject_tags_on_subject_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["name"], :name => "index_subjects_on_name"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "writings", :force => true do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "writings", ["author_id"], :name => "index_writings_on_author_id"
  add_index "writings", ["book_id", "author_id"], :name => "index_writings_on_book_id_and_author_id", :unique => true
  add_index "writings", ["book_id"], :name => "index_writings_on_book_id"

end
