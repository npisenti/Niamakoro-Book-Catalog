class AddCheckoutToggleToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :lent, :boolean, :default => false
  end

  def self.down
    remove_column :books, :lent
  end
end
