class Book < ActiveRecord::Base


  has_many :checkout_items, :dependent => :destroy, :dependent => :destroy

  has_many :writings
  has_many :authors, :through => :writings

  has_many :subject_tags
  has_many :subjects, :through => :subject_tags

  



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

end
