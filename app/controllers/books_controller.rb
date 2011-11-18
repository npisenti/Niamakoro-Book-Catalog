# coding: utf-8
class BooksController < ApplicationController

  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]

  
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
    @author_list = [Author.new] if @author_list.empty?
    @subject_list = [Subject.new] if @subject_list.empty?
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

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Le livre a été supprimé!"
    redirect_to books_path
  end

  def show

    # I hope this is good enough...
    #ref_url = request.referrer.split("/")[3]
    #@from_search = ref_url[0..7] == "?search=" unless ref_url.nil?
    

    @checkout = CheckoutItem.new
    @book = Book.find(params[:id])
    @checkout_items = @book.checkout_items.out
    @checkout_item = CheckoutItem.new
  end

  def index
    @books = Book.includes(:subjects).order('title ASC')
    @filename = 'toutes-livres.csv'
    @output_encoding = 'UTF-8'

    respond_to do |format|
      format.html
      format.csv 
    end
  end
      

  def search_bar
    output = Book.order("title ASC").map { |bt| bt.title }
    output.concat(Subject.order("name ASC").map { |st| st.name })
    #output = Book.search('pages').map{|bt| bt.title }

    
    render :json => output.to_json
  end


  def statistics
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html
      format.js { render :json => @book.stats.to_json }
      format.csv
    end
  end
end
