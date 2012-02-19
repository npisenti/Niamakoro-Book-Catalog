class AuditsController < ApplicationController

  def new
    @audit = Audit.new
    @books = Book.includes(:subjects, :authors).all
  end

  def create
    @audit = Audit.new(:books => params[:in_collection], :date_completed => Time.now, :notes => params[:audit][:notes])
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
    @audit = Audit.find(params[:id])
    @books = Book.includes(:subjects, :authors).find(@audit.books.keys)
  end

  def index
    @audits = Audit.all
  end
end
