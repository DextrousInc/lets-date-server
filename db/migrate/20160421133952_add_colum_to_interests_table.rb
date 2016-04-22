class AddColumToInterestsTable < ActiveRecord::Migration
  def change
    add_column :user_interests, :sub_category, :string
  end
end
