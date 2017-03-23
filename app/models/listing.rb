class Listing < ApplicationRecord
  validates :title, presence: true
  validates :address, presence: true
  validates :pax, presence: true
  belongs_to :user
end
