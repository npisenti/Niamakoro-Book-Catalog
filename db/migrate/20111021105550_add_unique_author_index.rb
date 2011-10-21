class AddUniqueAuthorIndex < ActiveRecord::Migration
  def self.up
    add_index :authors, [:first, :last], :unique => true
  end

  def self.down
    remove_index :authors, [:first, :last]
  end
end
