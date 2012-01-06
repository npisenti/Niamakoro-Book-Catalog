# coding: utf-8
class Grade < ActiveRecord::Base
  has_many :class_records

  validates_presence_of :year

  default_scope :order => 'year'


  def pretty_name
    if year == 0
      "Jardin"
    elsif year == 1
      "1ère année"
    else
      "#{year}ème année"
    end
  end
end
