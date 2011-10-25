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
    @subject_list = @book.subjects
  end

  def update
    @book = Book.find(params[:id])
    subjects = params[:subject].map { |f| Subject.find_or_create_by_name(f[1]["name"]) }
    if @book.update_attributes(params[:book].merge(:subjects => subjects))
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

  def search_bar
    @books = Book.all
    output_json = @books.map { |b| { :value => b.title } }

    respond_to do |format|
      format.json { render :json => output_json.to_json }
    end
  end
end
