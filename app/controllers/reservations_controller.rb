class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(reservation_params)

    @reservation.user = current_user
    @reservation.listing_id = params["listing_id"]
    if @reservation.check_overlapping_date == false
      @reservation.save
      flash[:reserve] = "Thank you for your reservation!"
      ReservationMailer.booking_email_to_customer(current_user, User.find(@reservation.listing.user_id), @reservation.id).deliver_now # this is to send confirmation email to customer after they have made a booking.
      ReservationMailer.booking_email_to_host(current_user, User.find(@reservation.listing.user_id), @reservation.id).deliver_now # this is to send notification email to the host for whoever customers who have made any bookings on their listing.
      redirect_to @reservation # redirect_to 'show' page
    else
      flash[:error] = "Error, the dates you choose is not available"
      # render 'listings/show'
      redirect_to listing_path(@reservation.listing) # redirect back to 'create', it will not clear ur cache
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    # convert date in String format to Date format, to conver back to String format, put .to_s
    # in create, the reservation_params with the date keyed in will be in date format because in schema, I have set date_start and date_end to Date format
    # but in edit, the newly key in date is in string format so need to change it to Date format in order to compared it with the res
    # can check the format in irb, put .class
    # a, b is arguments to be put in for new edited date_start and date_end, so that can compare with self, and res
    # if put self, will always comapare it with the existing reserved date
    # a = Date.strptime(params[:reservation][:date_start], '%Y/%m/%d') # newly filled in date_start
    # b = Date.strptime(params[:reservation][:date_end], '%Y/%m/%d') # newly filled in date_end
    x = params[:reservation][:date_start].to_date # .to_date is to change the date format
    y = params[:reservation][:date_end].to_date # .to_date is to change the date format

    if @reservation.check_overlapping_for_edit?(x,y) == false
      @reservation.update(reservation_params) # strong params, user can only key in the params require so hackers cannot hack
      flash[:success] = "Successfully updated your reservation"
      redirect_to @reservation # redirect to controller show to show the new listing
    else
      flash[:error] = "Error, please try again."
      render :edit # render to controller 'edit.html'
      # the difference between render and redirect_to is render is to the page, redirect_to is to the path,m it will go to config/routes.rb it will check out what path it is, and go to respective controller action
    end
  end

  def destroy
    @rervation = Reservation.find(params[:id]) # find the users/user_id/listings/:id
    @reservation.destroy
    flash[:delete] = "Successfully deleted!"
    redirect_to reservations_path
  end

private
  def reservation_params
    # first method with listing_id
    params.require(:reservation).permit(:date_start, :date_end, :guest, :listing_id)
    # second method without listing_id
    # params.require(:reservation).permit(:date_start, :date_end, :guest)
  end
end
