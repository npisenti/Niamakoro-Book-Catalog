class SubjectsController < ApplicationController

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.create(params[:id])
    if @subject.save
      redirect_to @subject
    else
      render 'new'
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      redirect_to @subject
    else
      render 'edit'
    end
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def index
    @subjects = Subject.all
  end

end
