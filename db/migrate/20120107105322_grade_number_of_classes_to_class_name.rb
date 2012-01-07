class GradeNumberOfClassesToClassName < ActiveRecord::Migration
  def self.up
    remove_column :grades, :number_classes
    add_column :grades, :name, :string
  end

  def self.down
    remove_column :grades, :name
    add_column :grades, :number_classes, :integer
  end
end
