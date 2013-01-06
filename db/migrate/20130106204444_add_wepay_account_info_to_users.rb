class AddWepayAccountInfoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :wepay_token, :string
    add_column :users, :wepay_id, :integer
    add_column :users, :wepay_account_id, :integer
    add_column :users, :wepay_account_uri, :string
  end
end
