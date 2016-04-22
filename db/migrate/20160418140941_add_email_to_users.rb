class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_latitude, :float, :precision => 15, :scale => 10, :null => false
    add_column :users, :home_longitude, :float, :precision => 15, :scale => 10, :null => false
    add_column :users, :email, :string, :null => false
    add_column :users, :password, :string, :null => false
  end
end
