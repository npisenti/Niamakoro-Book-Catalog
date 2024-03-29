class Book < ActiveRecord::Base
  require 'date'
  require 'date/delta'

  after_initialize :init


  has_many :checkout_items, :dependent => :destroy, :dependent => :destroy

  has_many :writings
  has_many :authors, :through => :writings

  has_many :subject_tags
  has_many :subjects, :through => :subject_tags

  has_and_belongs_to_many :audits

  scope :subject, lambda {|subject| Book.joins(:subjects).where(:subjects => {:name => subject} ) }
  scope :subject_search, lambda {|subject| Book.joins(:subjects).where('subjects.name LIKE ?', "%#{subject}%" ) }

  
  def num_copies
    nep = self.num_copies_nep.nil? ? 0 : self.num_copies_nep    # gotta be a better way...
    emd = self.num_copies_emd.nil? ? 0 : self.num_copies_emd
    nep + emd
  end

  def collection
    if self.num_copies_nep == 0
      coll = "Diarra"
    elsif self.num_copies_emd == 0
      coll = "NEP"
    else
      coll = "NEP / Diarra"
    end
    return coll
  end

  def generate(params)
    data = params['book']
    data['num_copies_nep'] = 0 if data['num_copies_nep'].blank?
    data['num_copies_emd'] = 0 if data['num_copies_emd'].blank?

    self.attributes=(data)
    self.subject_fields=(params['subjects'])
    self.author_fields=(params['authors'])
  end

  def author_fields=(authors_hash)
    author_arry = []
    authors_hash.values.each do |a|
      next if a['first'] == "" and a['last'] == ""
      author_arry << Author.find_or_create_by_first_and_last(a) 
    end
    self.authors = author_arry
  end

  def subject_fields=(subjects_hash)
    subject_arry = []
    subjects_hash.values.each do |s|
      next if s['name'] == ""
      subject_arry << Subject.find_or_create_by_name(s)
    end
    self.subjects = subject_arry
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

    [self.id.to_s, self.title.to_s, self.pub_year.to_s, self.genre.to_s, self.age_group.to_s, self.num_pages.to_s, self.num_copies_nep.to_s, self.num_copies_emd.to_s, self.series_title.to_s, self.series_number.to_s, self.language, self.summary.to_s, self.notes.to_s, authors_str, subjects_str, self.checkout_items.count]

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
    return [[]] if checkouts.empty?

    offset = delta(Time.now, checkouts[0].created_at)

    data = {} 
    (0..offset).each do |i|
      data[i - offset] = self.checkout_tally(Time.now - i.days)
    end
    
    return data.to_a
      
  end

  def checkout_tally(day)
    self.checkout_items.count_date(day).length
  end

  private
  def delta(d1, d2)
    Date::Delta.diff(d1.to_date, d2.to_date).days
  end

  def init
    self.num_copies_nep ||= 1
  end
end
