class CheckoutItemsController < ApplicationController

  def new
    @checkout = CheckoutItem.new
  end

  def create
    @checkout = CheckoutItem.create(params[:checkout_item])
    if @checkout.save
      redirect_to book_path(@checkout.book_id)
    else
      render 'new'
    end
  end

  def edit
    @checkout = CheckoutItem.find(params[:id])
  end

  def update
    @checkout = CheckoutItem.find(params[:id])
    if @checkout.update_attributes(params[:checkout_item])
      redirect_to book_path(@checkout.book_id)
    else
      render 'edit'
    end
  end
end
