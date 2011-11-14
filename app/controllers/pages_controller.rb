class PagesController < ApplicationController
  before_filter :authenticate, :only => [ :admin ]

  def home
    @search_query = ""
    if params[:search]
      @books = Book.search(params[:search])
      @subject_books = Subject.search(params[:search]).map {|s| s.books }.flatten.uniq
      @books.concat(@subject_books)
      @search_query = params[:search]
    end
  end

  def admin
  end

end
