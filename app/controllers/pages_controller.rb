class PagesController < ApplicationController
  before_filter :authenticate, :only => [ :admin ]

  def home
    @search_query = ""
    if params[:search]
      @subject = Subject.find_by_name(params[:search])
      @books = @subject.nil? ? [] : @subject.books
      @search_query = params[:search]
    end
  end

  def admin
  end

end
