class Audit < ActiveRecord::Base
  has_and_belongs_to_many :books

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
