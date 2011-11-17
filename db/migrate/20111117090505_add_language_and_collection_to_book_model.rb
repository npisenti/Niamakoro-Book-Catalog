class AddLanguageAndCollectionToBookModel < ActiveRecord::Migration
  def self.up
    add_column :books, :language, :string
    add_column :books, :collection, :string, :default => "NEP"
    add_index :books, :collection
    add_index :books, :language
  end

  def self.down
    remove_column :books, :language
    remove_column :books, :collection
  end
end
