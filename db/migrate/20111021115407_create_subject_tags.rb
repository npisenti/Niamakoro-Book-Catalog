class CreateSubjectTags < ActiveRecord::Migration
  def self.up
    create_table :subject_tags do |t|
      t.integer :book_id
      t.integer :subject_id

      t.timestamps
    end
    add_index :subject_tags, :subject_id
    add_index :subject_tags, :book_id
    add_index :subject_tags, [:book_id, :subject_id], :unique => true

  end

  def self.down
    drop_table :subject_tags
  end
end
