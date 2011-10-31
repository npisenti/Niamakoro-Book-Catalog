class PagesController < ApplicationController

  def home
    @search_query = ""
    if params[:search]
      @subject = Subject.find_by_name(params[:search])
      @books = @subject.nil? ? [] : @subject.books
      @search_query = params[:search]
    end
  end

end
