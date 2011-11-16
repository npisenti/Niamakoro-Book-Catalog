class AddCheckoutCountToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :checkout_count, :integer, :default => 0
    add_index :books, :checkout_count
  end

  def self.down
    remove_column :books, :checkout_count
    remove_index :books, :checkout_count
  end
end
