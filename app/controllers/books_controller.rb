class BooksController < ApplicationController

  
  def new
    @book = Book.new
    @subject_list = [Subject.new]
    @author_list = [Author.new]
  end

  def create

    @book = Book.new
    @book.generate(params)

    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @subject_list = @book.subjects
    @author_list = @book.authors
  end

  def update

    @book = Book.find(params[:id])
    @book.generate(params)

    if @book.save
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
    # output_json = @books.map { |b| { :value => b.title } }
    output_json = @books.map {|b| b.subjects.map { |s| { :value => s.name } } }.flatten


    respond_to do |format|
      format.json { render :json => output_json.to_json }
    end
  end
end
