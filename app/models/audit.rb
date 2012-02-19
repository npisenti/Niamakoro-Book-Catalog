class Audit < ActiveRecord::Base

  serialize :books, Hash

  def books
    read_attribute(:books) || write_attribute(:books, {})
  end

  def books=(hash)
    hash.each do |key, value|
      present = value.to_i
      missing = Book.find(key).num_copies - present
      hash[key] = { :present => present, :missing => missing }
    end
    write_attribute(:books, hash)
  end

  def in_collection
    output = {}
    books.each do |book|
      output[book.id.to_s] = 1
    end
    return output
  end

  def in_collection=(hash)
    hash.delete_if { |key, value| value.to_s != "1" }
    self.books = Book.find(hash.keys)
  end

  def missing
    Book.includes(:subjects, :authors).all.reject { |b| books.include?(b) }
  end

      
end
