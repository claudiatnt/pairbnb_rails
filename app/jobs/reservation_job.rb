class ReservationJob < ApplicationJob
  queue_as :default

  # def perform(customer_id, host_id, reservation_id)
  #   ReservationMailer.booking_email_to_customer(customer_id, host_id, reservation_id)
  #   ReservationMailer.booking_email_to_host(customer_id, host_id, reservation_id)
  # end

end
