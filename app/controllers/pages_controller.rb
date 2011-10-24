class PagesController < ApplicationController

  def home
    @test = Book.all.map { |b| b.title }
  end

end
