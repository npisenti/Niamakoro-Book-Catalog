class BooksController < ApplicationController

  before_filter :authenticate, :only => [:new, :create, :edit, :update ]

  
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
    @search_term = params[:search]

    @checkout = CheckoutItem.new
    @book = Book.find(params[:id])
    @checkout_items = @book.checkout_items.out
    @checkout_item = CheckoutItem.new
  end

  def index
    @books = Book.all
    respond_to do |format|
      format.html
      format.csv { 
        require 'csv'
        @csv_string = CSV.generate do |csv|
          csv << ["ID", "titre", "publication", "genre", "age", "nombre_pages", "nom_copies", "titre_serie", "nombre_serie", "resume", "notes", "auters", "sujets"]
          @books.each do |b|
            csv << b.csv_array
          end
        end
        
        render :text => @csv_string
      }
    end
      
  end

  def search_bar
  #  output = Subject.order("name ASC").map { |st| st.name }
  #  output_json = Subject.order("name ASC").map { |st| {:value =>  st.name } }
    output = Book.order("title ASC").map { |bt| bt.title }
    output.concat(Subject.order("name ASC").map { |st| st.name })

    
    render :json => output.to_json
  end

  def csv
  end

end

