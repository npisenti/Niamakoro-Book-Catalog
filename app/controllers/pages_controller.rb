class PagesController < ApplicationController
  before_filter :authenticate, :only => [ :admin ]

  def home
    @search_query = ""
    if params[:search]
      @subject = Subject.find_by_name(params[:search])
      @book = Book.find_by_title(params[:search])
      @books = @subject.nil? ? [] : @subject.books

      @books.concat([Book.find_by_title(params[:search])]) unless @book.nil?
      @search_query = params[:search]
    end
  end

  def admin
  end

end
