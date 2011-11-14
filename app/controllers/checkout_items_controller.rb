class CheckoutItemsController < ApplicationController

  def new
    @checkout = CheckoutItem.new
  end

  def create
    @checkout = CheckoutItem.create(params[:checkout_item])
    @book = Book.find(params[:checkout_item]['book_id'])
    if @checkout.save
      render :text => "hello, this rendered"
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

  def checkin_many
    
    # Check to see if no books to check in...
    if params[:checkout_item].nil?
      redirect_to home_path
      return
    end

    @book = Book.find(params[:checkout_item].values.first['book_id'])

    params[:checkout_item].each do |co|
      if co[1]['status'] == "1"
        checkin = CheckoutItem.find(co[0])
        checkin.status = 0
        checkin.save!
      end
    end
    redirect_to @book
  end
end
