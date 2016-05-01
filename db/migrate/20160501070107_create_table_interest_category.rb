class CreateTableInterestCategory < ActiveRecord::Migration
  def change
    create_table :interest_categories do |t|
      t.column :category, :string, :null => false
      t.column :place, :string, :null => false
      t.timestamps null: false
    end
    add_column :user_interests, :interest_category_id, :integer, :null => false
    add_foreign_key :user_interests, :interest_categories
  end
end
