class AuditsController < ApplicationController

  def new
    @audit = Audit.new
    @books = Book.includes(:subjects, :authors).all
  end

  def create
    @audit = Audit.new(:in_collection => params[:audit][:in_collection], :date_completed => Time.now, :notes => params[:audit][:notes])
    if @audit.save
      redirect_to @audit
    else
      @books = Book.all
      render 'new'
    end
    
  end

  def edit
  end

  def update
  end

  def show
    @audit = Audit.includes(:books => [:subjects, :authors]).find(params[:id])
  end

  def index
    @audits = Audit.all
  end
end
