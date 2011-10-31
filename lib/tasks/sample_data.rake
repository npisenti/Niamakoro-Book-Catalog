
require 'csv'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    BOOKS = File.join( File.dirname(__FILE__), '..', '..', 'db/SeedData/books.csv')

    CSV.foreach(BOOKS, :return_headers => false, :headers => :first_row) do |row|
      author_params = { "1" => { "last" => row['author_1_last'], "first" => row['author_1_first'] }, "2" => { "last" => row['author_2_last'], "first" => row['author_2_first'] } } 
      author_params.delete("2") if row['author_2_last'] == nil
      author_params.delete("1") if row['author_1_last'] == nil

      subjects = row['subjects'].split(', ')
      subject_params = {}
      subjects.each_index{ |i| subject_params[i.to_s] = { "name" => subjects[i].downcase } }
      
      puts row['id']
      puts author_params
      puts subject_params

      @book = Book.new
      @book.generate({ "book" => {
        :title => row['title'], 
        :pub_year => row['pub_year'], 
        :genre => row['genre'], 
        :age_group => row['age_group'], 
        :num_pages => row['num_pages'], 
        :num_copies => row['num_copies'], 
        :series_title => row['series_title'], 
        :series_number => row['series_number'], 
        :notes => row['notes'] }, 
        "authors" => author_params,
        "subjects" => subject_params
      })

      @book.save

    end
  end
end

