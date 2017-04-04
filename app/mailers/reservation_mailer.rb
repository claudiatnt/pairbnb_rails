class ReservationMailer < ApplicationMailer # this is like a controller specially for mailer so is not under controllers folder.
  def booking_email_to_customer(customer_id, host_id, reservation_id)
    @customer = User.find(customer_id)
    @host = User.find(host_id)
    @reservation_id = reservation_id
    @url  = 'http://facebook.com'
    mail(to: @customer.email, subject: 'Confirmation email on your new booking!')
  end

  def booking_email_to_host(customer_id, host_id, reservation_id)
    @customer = User.find(customer_id)
    @host = User.find(host_id)
    @reservation_id = reservation_id
    @url  = 'http://facebook.com'
    mail(to: @host.email, subject: 'There is a new booking for your listing!')
  end
end
