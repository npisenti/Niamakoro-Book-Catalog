class ChangeCollectionCopies < ActiveRecord::Migration
  # Allows for a book to belong in multiple collections
  # Specifies number of copies in the NEP and Maourou Diarra collections separately
  def self.up
    remove_index :books, :collection
    change_table :books do |t|
      t.integer :num_copies_nep
      t.integer :num_copies_emd   # for Ecole Maourou Diarra
    end
    Book.reset_column_information
    Book.all.each do |b|
      if b.collection == "NEP"
        b.num_copies_nep = b.num_copies
        b.num_copies_emd = 0
      elsif b.collection == "Diarra"
        b.num_copies_emd = b.num_copies
        b.num_copies_nep = 0
      end
      b.save!
    end

    change_table :books do |t|
      t.remove :num_copies, :collection
      t.index :num_copies_nep
      t.index :num_copies_emd
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't recover information."
  end
end
