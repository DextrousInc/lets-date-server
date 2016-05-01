class InterestCategory < ActiveRecord::Base
  has_many :user_interests
end
