class CreateUserInterests < ActiveRecord::Migration
  def change
    create_table :user_interests do |t|
      t.column :user_id, :integer, :null => false
      t.column :category, :string, :null => false
      t.column :names, :string, :null => false
      t.timestamps null: false
    end
  end
end
