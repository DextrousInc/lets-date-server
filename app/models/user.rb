class User < ActiveRecord::Base
  has_many :user_interests
  has_secure_password
  validates_uniqueness_of :email
end
