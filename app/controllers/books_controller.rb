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
    @checkout = CheckoutItem.new
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end

  def search_bar
    output = Subject.order("name ASC").map { |st| st.name }
    output_json = Subject.order("name ASC").map { |st| {:value =>  st.name } }
    render :json => output.to_json
  end

  def search_bar2
    #output_json = SubjectTag.all.map { |st| { :label => "Sujet: #{st.subject.name}", :value => st.subject.name } }.uniq
    output_json = Subject.order("name ASC").map { |st| {:label => "#{st.name} (Sujet)", :value => st.name } }

    respond_to do |format|
      format.json { render :json => output_json.to_json }
    end
  end

  def checkout
    @book = Book.find(params[:id])
    @book.lent = params[:lent]
    @book.save
  end
end
