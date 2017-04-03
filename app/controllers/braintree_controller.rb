class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:id])
  end

  def checkout
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  @reservation = Reservation.find(params[:checkout_form][:id])
  result = Braintree::Transaction.sale(
  #  :amount => "10.00",
   :amount => @reservation.listing.price * (@reservation.date_end.to_date - @reservation.date_start.to_date).to_i, # link the payment to reservation/:id to calculate how many nights times the price per night
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )
    if result.success?
      flash[:success] = "Transaction successful! Thank you for your payment of RM#{@reservation.listing.price * (@reservation.date_end.to_date - @reservation.date_start.to_date).to_i}"
      redirect_to :root
    else
      flash[:error] = "Transaction failed. Please try again."
      redirect_to :root
    end
  end

end
