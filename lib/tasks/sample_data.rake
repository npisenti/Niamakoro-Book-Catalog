
require 'csv'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    BOOKS = File.join( File.dirname(__FILE__), '..', '..', 'db/SeedData/books.csv')

    CSV.foreach(BOOKS, :encoding => 'UTF-8', :return_headers => false, :headers => :first_row) do |row|
      authors = [[]] # Initializes incase there is no author...
      authors = row['auters'].split(";").map{|e| e.split(",")} unless row['auters'] == nil
      subjects = row['sujets'].split(";")

      subject_params = {}
      author_params = {}

      authors.each_index{|i| author_params[i.to_s] = { "last" => authors[i][0], "first" => authors[i][1] } } unless row['auters'] == nil
      subjects.each_index{ |i| subject_params[i.to_s] = { "name" => Unicode::downcase(subjects[i]) } } unless row['sujets'] == nil
      

      @book = Book.new
      @book.generate({ "book" => {
        :title => Unicode::capitalize(row['titre']), 
        :pub_year => row['publication'], 
        :genre => row['genre'], 
        :age_group => Unicode::capitalize(row['age']), 
        :num_pages => row['nombre_pages'], 
        :num_copies => row['nombre_copies'], 
        :series_title => row['titre_serie'], 
        :series_number => row['nombre_serie'], 
        :collection => row['collection'],
        :language => row['langue'],
        :summary => row['resume'], 
        :notes => row['notes'] }, 
        "authors" => author_params,
        "subjects" => subject_params
      })

      @book.save

    end
  end
end

