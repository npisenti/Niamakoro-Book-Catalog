class Book < ActiveRecord::Base
  require 'date'
  require 'date/delta'



  has_many :checkout_items, :dependent => :destroy, :dependent => :destroy

  has_many :writings
  has_many :authors, :through => :writings

  has_many :subject_tags
  has_many :subjects, :through => :subject_tags

  scope :subject, lambda {|subject| Book.joins(:subjects).where(:subjects => {:name => subject} ) }
  

  



  def generate(params)
    self.attributes=(params['book'])
    self.subject_fields=(params['subjects'])
    self.author_fields=(params['authors'])
  end

  def author_fields=(authors_hash)
    self.authors = authors_hash.values.map { |a| Author.find_or_create_by_first_and_last(a) } 
  end

  def subject_fields=(subjects_hash)
    self.subjects = subjects_hash.values.map { |s| Subject.find_or_create_by_name(s["name"]) }
  end

  def checked_out
    self.checkout_items.out.length
  end

  def checked_in
    self.num_copies - self.checkout_items.out.length
  end

  def csv_array
    authors_str = self.authors.map{|a| "#{a.last},#{a.first}"}.join(";")
    subjects_str = self.subjects.map{|s| "#{s.name}"}.join(";")
    authors_str = "" if authors_str.empty?
    subjects_str = "" if subjects_str.empty?

    [self.id.to_s, self.title.to_s, self.pub_year.to_s, self.genre.to_s, self.age_group.to_s, self.num_pages.to_s, self.num_copies.to_s, self.series_title.to_s, self.series_number.to_s, self.summary.to_s, self.notes.to_s, authors_str, subjects_str, self.checkout_items.count]

  end

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ? OR summary LIKE ?', "%#{search}%", "%#{search}%"])
    end
  end

  def self.popular(limit)
    Book.limit(limit).order('checkout_count DESC')
  end

  def stats
    checkouts = self.checkout_items
    offset = delta(checkouts[0].created_at, Time.now)
    data = {} 
    checkouts.each do |c|
      time_ago = delta(c.created_at, Time.now) - offset
      if data[time_ago] == nil
        data[time_ago] = 1
      else
        data[time_ago] += 1
      end
    end

    return data.to_a
      
  end


  private
  def delta(d1, d2)
    Date::Delta.diff(d1.to_date, d2.to_date).days
  end
end
