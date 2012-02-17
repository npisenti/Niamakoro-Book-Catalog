class CreateAuditsJoinTable < ActiveRecord::Migration
  def self.up

    create_table :audits_books, :id => false do |t|
      t.integer :book_id
      t.integer :audit_id
    end
  end

  def self.down
    drop_table :audits_books
  end
end
