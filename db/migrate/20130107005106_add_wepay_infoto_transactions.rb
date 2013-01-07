class AddWepayInfotoTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :checkout_uri, :string
    add_column :transactions, :checkout_id, :integer
  end
end
