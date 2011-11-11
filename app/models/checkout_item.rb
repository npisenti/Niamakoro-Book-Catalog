class CheckoutItem < ActiveRecord::Base
  belongs_to :book
  
  scope :open, CheckoutItem.where(:status => true)


end
