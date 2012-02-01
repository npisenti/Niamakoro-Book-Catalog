# coding: utf-8
class Grade < ActiveRecord::Base
  has_many :class_records

  validates_presence_of :year

  default_scope :order => 'year'


  def pretty_year
    if year == 0
      "Jardin"
    elsif year == 1
      "1ère année"
    else
      "#{year}ème année"
    end
  end


  # Some statistic functions...

  def teacher_present_count
    class_records.where(:teacher => true).count
  end

  def teacher_absent_count
    class_records.where(:teacher => false).count
  end

  def teacher_attendance
    present = teacher_present_count
    absent = teacher_absent_count
    if present + absent == 0
      "N/A"
    else
      "#{(present * 100.0 / (present + absent)).round} %"
    end
  end

  def average_attendance
    students = ClassRecord.where(:grade_id => id).average('attendance')
    students.nil? ? 0 : students.round(1)
  end

  def stats
    return [[]] if class_records.empty?
    data = {}
    class_records.reverse.each_with_index do |r, i|
      data[i] = r.attendance || 0
    end
    return data.to_a
  end
end
