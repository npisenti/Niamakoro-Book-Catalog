class CreateWritings < ActiveRecord::Migration
  def self.up
    create_table :writings do |t|
      t.integer :book_id
      t.integer :author_id

      t.timestamps
    end
    add_index :writings, :book_id
    add_index :writings, :author_id
    add_index :writings, [:book_id, :author_id], :unique => true
  end

  def self.down
    drop_table :writings
  end
end
