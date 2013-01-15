class AddEmailtoAuthentications < ActiveRecord::Migration
  def change
  	add_column :authentications, :email, :string
    add_column :authentications, :name, :string
  end
end

