class PagesController < ApplicationController
  before_filter :authenticate, :only => [ :admin ]

  def home
    @search_query = ""
    if params[:search]
      @book = Book.includes(:subjects).where(:title => params[:search])[0]
      redirect_to @book if @book

      @books = Book.includes(:subjects).search(params[:search])
      #@subject_books = Subject.search(params[:search]).map {|s| s.books }.flatten
      @subject_books = Book.includes(:subjects).subject_search(params[:search])
      @books.concat(@subject_books).uniq!
      @search_query = params[:search]
    end
  end

  def admin
    @checkouts = CheckoutItem.out
  end

  def stats
    @book_count = Book.count
    @checkout_count = CheckoutItem.count
    @popular = Book.popular(10)
    @NEP_count = Book.where('num_copies_nep > 0').count
    @Diarra_count = Book.where('num_copies_emd > 0').count
  end

  def class_stats
    @grades = Grade.all
    respond_to do |format|
      format.html
      format.csv
    end
  end

  def batch_checkin
    @checkout_items = CheckoutItem.out
    @checkout_item = CheckoutItem.new
  end

  def batch_checkout
  end
end
