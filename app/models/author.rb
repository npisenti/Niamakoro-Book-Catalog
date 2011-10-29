class Author < ActiveRecord::Base
  has_many :writings
  has_many :books, :through => :writings

  attr_accessible :first, :last
end
