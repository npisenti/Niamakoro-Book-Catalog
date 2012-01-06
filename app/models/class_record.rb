class ClassRecord < ActiveRecord::Base
  belongs_to :grade

  validates_presence_of :grade
end
