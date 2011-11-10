class SubjectsController < ApplicationController

  before_filter :authenticate, :only => [:new, :create, :edit, :update ]

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
    @subjects = Subject.order("name ASC")

    @output_json = @subjects.map { |s| s.name }

    respond_to do |format|
      format.html
      format.json { render :json => output_json.to_json } 
    end
  end

  
end
