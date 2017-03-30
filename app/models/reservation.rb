class Reservation < ApplicationRecord
  validates :date_start ,presence: true
  validates :date_end ,presence: true
  validates :guest ,presence: true
  validate :check_overlapping_date

  belongs_to :user
  belongs_to :listing

  def check_overlapping_date

    # self is @reservation, and it's listing with all the reservations that have been made, put it in res and compare to the existing @reservation that is going to be made
    self.listing.reservations.each do |res|

      # loop the listing's reservations in res and compare it to self/@reservation in overlap? method
      if overlap?(self, res)
        return true # it will return true and stop the loop if it overlaps, then will go to error message
      end
    end
    return false # when it compares with all the reservation of the listing and there is no overlapping, then it will return false and make a reservation for the user
  end

  def overlap?(x,y)
    (x.date_start - y.date_end) * (y.date_start - x.date_end) > 0
  end

  # checking if compare this date with all the current existed reservations, once its overlap it will return true
  def check_overlapping_for_edit?(x,y) # instance method, so the self here refers to @reservation object
    self.listing.reservations.each do |res|
      if (x - res.date_end) * (res.date_start - y) > 0
        return true
      end
    end

    return false #means the equation is never > 0, means NO OVERLAP
  end

end
