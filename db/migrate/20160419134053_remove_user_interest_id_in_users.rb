class RemoveUserInterestIdInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :user_interest_id
  end
end
