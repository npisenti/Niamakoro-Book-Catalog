class AuthorsController < ApplicationController

  def new
    @author = Author.new
  end

  def create
    @author = Author.create(params[:id])
    if @author.save
      redirect_to @author
    else
      render 'new'
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      redirect_to @author
    else
      render 'edit'
    end
  end

  def show
    @author = Author.find(params[:id])
  end

  def index
    @authors = Author.all
  end
end
