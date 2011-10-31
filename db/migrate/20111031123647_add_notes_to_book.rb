class AddNotesToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :notes, :text
  end

  def self.down
    remove_column :books, :notes
  end
end
