class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :first
      t.string :last

      t.timestamps
    end
    add_index :authors, :first
    add_index :authors, :last

  end

  def self.down
    drop_table :authors
  end
end
