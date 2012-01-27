class CheckoutItemsController < ApplicationController
  before_filter :authenticate

  def new
    @checkout = CheckoutItem.new
  end

  def create
    @checkout_me = CheckoutItem.create(params[:checkout_item])
    @book = Book.find(params[:checkout_item]['book_id'])



    @checkout = CheckoutItem.new
    @checkout_items = @book.checkout_items.out
    @checkout_item = CheckoutItem.new

    if @checkout_me.save

      respond_to do |format|
        format.js {
          render 'create'
        }
      end
    end
  end

  def edit
    @checkout = CheckoutItem.find(params[:id])
  end

  def update
    @checkout_me = CheckoutItem.find(params[:id])
    @book = @checkout_me.book 

    @checkout = CheckoutItem.new
    @checkout_items = @book.checkout_items.out
    @checkout_item = CheckoutItem.new

    if @checkout_me.update_attributes(params[:checkout_item])

      respond_to do |format|
        format.js {
          render 'update'
        }
      end
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
        checkin.status = false
        checkin.save!
      end
    end

    @checkout = CheckoutItem.new
    @checkout_items = @book.checkout_items.out
    @checkout_item = CheckoutItem.new


    respond_to do |format|
      format.js {
        render 'update'
      }
    end
  end



  def batch_checkin
    params[:checkout_item].each do |co|
      if co[1]['status'] == "1" || !co[1]['next'].blank?
        checkin = checkin_book(co[0])
        checkout_book(co[1]['next'], checkin.notes) unless co[1]['next'].blank?
      end

    end
    redirect_to batch_checkin_path
  end

  def batch_checkout
    params[:book_title].each do |b|
      checkout_book(b[1], params[:checkout_notes][b[0]])
    end

    redirect_to batch_checkin_path
  end


    
  private
  def checkout_book(title, notes)
    book = Book.find_by_title(title)
    if !book.nil?
      CheckoutItem.create(:book => book , :notes => notes, :status => true)
    end
  end

  def checkin_book(id)
    checkin = CheckoutItem.find(id)
    if !checkin.nil?
      checkin.status = false
      checkin.save!
    end
    return checkin
  end



end
