class User < ApplicationRecord
  include Clearance::User
  has_many :listings, :dependent => :destroy # need to add in listings as you add in the listings table to have a user_id in the listing's table
  has_many :authentications, :dependent => :destroy
  mount_uploaders :photos, PhotoUploader
  serialize :photos, Array

  def self.create_with_auth_and_hash(authentication, auth_hash)
      # byebug
      user = User.create!(firstname: auth_hash["info"]["first_name"], lastname: auth_hash["info"]["last_name"], email: auth_hash["info"]["email"])
      user.authentications << (authentication)
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

  # or can put a random password: '1234' in line 8

end
