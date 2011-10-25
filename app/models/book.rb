class Book < ActiveRecord::Base
  has_many :writings
  has_many :authors, :through => :writings

  has_many :subject_tags
  has_many :subjects, :through => :subject_tags

end
