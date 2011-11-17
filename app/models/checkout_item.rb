class CheckoutItem < ActiveRecord::Base
  belongs_to :book

  after_create :update_checkout_count

  default_scope order('created_at ASC')
  
  scope :out, CheckoutItem.where(:status => true)
  scope :count_date, lambda {|date| CheckoutItem.where(:created_at => (date.to_date)..((date + 1.day).to_date))}

  private
  def update_checkout_count
    b = self.book
    b.checkout_count = b.checkout_items.count
    b.save
  end

end
