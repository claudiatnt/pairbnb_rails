class Listing < ApplicationRecord
  validates :title, presence: true
  validates :address, presence: true
  validates :pax, presence: true
  validates :room_number, presence: true
  validates :bed_number, presence: true
  validates :price, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :description, presence: true
  validates :property_type, presence: true
  
  belongs_to :user
  has_many :reservations, dependent: :destroy
  mount_uploaders :photos, PhotoUploader
  serialize :photos, Array

end
