class Subject < ActiveRecord::Base
  has_many :subject_tags
  has_many :books, :through => :subject_tags
end