class CreateCheckoutItems < ActiveRecord::Migration
  def self.up
    create_table :checkout_items do |t|
      t.integer :book_id
      t.boolean :status
      t.string  :notes

      t.timestamps
    end
    add_index :checkout_items, :book_id
    add_index :checkout_items, :status
  end

  def self.down
    drop_table :checkout_items
  end
end
