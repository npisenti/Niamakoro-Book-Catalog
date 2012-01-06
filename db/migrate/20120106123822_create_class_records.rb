class CreateClassRecords < ActiveRecord::Migration
  def self.up
    create_table :class_records do |t|
      t.integer :grade_id
      t.datetime :arrival
      t.datetime :departure
      t.boolean :teacher
      t.integer :attendance
      t.text :notes

      t.timestamps
    end
    add_index :class_records, :teacher
    add_index :class_records, :grade_id
    add_index :class_records, :attendance
  end

  def self.down
    drop_table :class_records
  end
end
