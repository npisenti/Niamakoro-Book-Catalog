class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.datetime :date_completed
      t.text  :notes

      t.timestamps
    end
    add_index :audits, :date_completed
  end

  def self.down
    drop_table :audits
  end
end
