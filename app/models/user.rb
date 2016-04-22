class User < ActiveRecord::Base
  has_many :user_interests
  validates_uniqueness_of :email
end
