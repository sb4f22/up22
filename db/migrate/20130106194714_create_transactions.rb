class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :funder_id
      t.integer :funded_id
      t.integer :gift_id
      t.decimal :amount
      t.string  :description
      t.timestamps
    end
    add_index :transactions, :funder_id
    add_index :transactions, :funded_id
    add_index :transactions, [:funder_id, :funded_id]
  end

  def self.down
    drop_table :transactions
  end
end
