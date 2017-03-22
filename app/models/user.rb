class User < ApplicationRecord
  include Clearance::User

  has_many :authentications, :dependent => :destroy

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
