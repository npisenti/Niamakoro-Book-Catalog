class CheckoutItem < ActiveRecord::Base
  belongs_to :book

  after_create :update_checkout_count
  
  scope :out, CheckoutItem.where(:status => true)

  private
  def update_checkout_count
    b = self.book
    b.checkout_count = b.checkout_items.count
    b.save
  end

end
