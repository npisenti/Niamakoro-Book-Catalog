class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end
end
