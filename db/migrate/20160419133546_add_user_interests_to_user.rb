class AddUserInterestsToUser < ActiveRecord::Migration
  def change
    add_foreign_key :user_interests, :users
  end
end
