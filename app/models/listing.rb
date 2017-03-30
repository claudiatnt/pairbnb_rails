class Listing < ApplicationRecord
  validates :title, presence: true
  validates :address, presence: true
  validates :pax, presence: true
  belongs_to :user
  has_many :reservations, dependent: :destroy
  mount_uploaders :photos, PhotoUploader
  serialize :photos, Array

end
