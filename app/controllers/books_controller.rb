class BooksController < ApplicationController

  def new
    @book = Book.new
    @book.authors = [Author.new]
    @book.subjects = [Subject.new]
  end

  def create
    @book = Book.create(params[:book])
    @author = Author.find_or_create_by_first_and_last(params[:author])
    @book.authors = [@author]
    @subject = Subject.find_or_create_by_name(params[:subject])
    @book.subjects = [@subject]

    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      redirect_to @book
    else
      render 'edit'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end
end
