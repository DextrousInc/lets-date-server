class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :first_name, :string, :null => false
      t.column :last_name, :string
      t.column :dob, :date, :null => false
      t.column :gender, :string, :null => false
      t.column :email, :string, :null => false
      t.column :password, :string, :null => false
      t.column :home_latitude, :float, :precision => 15, :scale => 10, :null => false
      t.column :home_longitude, :float, :precision => 15, :scale => 10, :null => false
      t.column :preference, :string, :null => false
      t.column :user_interest_id, :integer, :null => false
      t.timestamps null: false
    end
  end
end
