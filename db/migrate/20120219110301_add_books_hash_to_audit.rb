class AddBooksHashToAudit < ActiveRecord::Migration
  def self.up
    add_column :audits, :books, :text
    drop_table :audits_books
  end

  def self.down
    remove_column :audits, :books
    create_table :audits_books do |t|
      t.integer :audit_id
      t.integer :book_id
    end
  end
end
