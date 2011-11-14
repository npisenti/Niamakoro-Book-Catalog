class CheckoutItem < ActiveRecord::Base
  belongs_to :book
  
  scope :out, CheckoutItem.where(:status => true)


end
