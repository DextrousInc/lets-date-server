class CreateInterestCategories < ActiveRecord::Migration
  def change
    remove_column :user_interests, :category
    remove_column :user_interests, :names
    add_column :user_interests, :interest_name, :string, :null => false
  end
end
