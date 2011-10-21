class SubjectTag < ActiveRecord::Base
  belongs_to :subject
  belongs_to :book
end
