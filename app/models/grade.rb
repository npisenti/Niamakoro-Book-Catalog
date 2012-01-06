class Grade < ActiveRecord::Base
  has_many :class_records

  validates_presence_of :year
end
