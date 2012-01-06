class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.integer :year
      t.integer :number_students
      t.integer :number_classes
      t.text :notes

      t.timestamps
    end
    add_index :grades, :year
  end

  def self.down
    drop_table :grades
  end
end
