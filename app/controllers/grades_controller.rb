class GradesController < ApplicationController

  def new
    @grade = Grade.new
  end
  
  def create
    @grade = Grade.new(params[:grade])
    if @grade.save
      redirect_to @grade
    else
      render 'new'
    end
  end

  def show
    @grade = Grade.find(params[:id])
  end

  def edit
    @grade = Grade.find(params[:id])
  end

  def update
    @grade = Grade.find(params[:id])
    @grade.update_attributes(params[:grade])
    if @grade.save
      redirect_to @grade
    else
      render 'edit'
    end
  end

  def index
    @grades = Grade.all
  end


 def statistics
    @grade = Grade.find(params[:id])
    @filename = "gr-#{@grade.year}-statistics.csv"
    @output_encoding = 'UTF-8'

    respond_to do |format|
      format.js { render :json => @grade.stats.to_json }
      format.csv 
    end
  end

end
