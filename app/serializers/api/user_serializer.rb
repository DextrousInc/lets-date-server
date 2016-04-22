class Api::UserSerializer < Api::BaseSerializer
  attributes :id, :email, :first_name, :last_name, :home_latitude, :home_longitude, :created_at, :updated_at

  has_many :user_interests

end
