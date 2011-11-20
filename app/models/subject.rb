class Subject < ActiveRecord::Base
  has_many :subject_tags
  has_many :books, :through => :subject_tags

  attr_accessible :name, :description

  

  def self.search(search)
    if search
      Subject.includes(:books).find(:all, :conditions => ['name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
    end
  end

end
