class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.integer :pub_year
      t.string :genre
      t.string :age_group
      t.integer :num_pages
      t.integer :num_copies
      t.string :series_title
      t.integer :series_number
      t.text :summary

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
