class ClassRecordsController < ApplicationController


  def new
    @class_record = ClassRecord.new
  end

  def create
    grade = Grade.find(params[:class_record][:grade_id])
    data = ClassRecord.fix_params(params)

    @class_record = grade.class_records.build(:arrival => data[:class_record][:arrival],
                      :departure => data[:class_record][:departure],
                      :teacher_attendance => data[:class_record][:teacher_attendance],
                      :attendance => data[:class_record][:attendance],
                      :notes => data[:class_record][:notes])

    if @class_record.save
      redirect_to grade #@class_record
    else
      render 'new'
    end
  end

  def edit
    @class_record = ClassRecord.find(params[:id])
  end

  def update
    @class_record = ClassRecord.find(params[:id])
    data = ClassRecord.fix_params(params)

    @class_record.update_attributes(:arrival => data[:class_record][:arrival],
                      :departure => data[:class_record][:departure],
                      :teacher_attendance => data[:class_record][:teacher_attendance],
                      :attendance => data[:class_record][:attendance],
                      :notes => data[:class_record][:notes])
    if @class_record.save
      redirect_to @class_record
    else
      render 'edit'
    end
  end

  def show
    @class_record = ClassRecord.find(params[:id])
  end

  def index
    @class_records = ClassRecord.all
  end
end
