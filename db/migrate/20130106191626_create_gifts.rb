class CreateGifts < ActiveRecord::Migration
  def self.up
    create_table :gifts do |t|
      t.integer :campaign_id
      t.string :name
      t.string :description
      t.integer :stock
      t.decimal :price
      t.timestamps
    end
     add_index :gifts,:price
  end

  def self.down
    drop_table :gifts
  end
end
