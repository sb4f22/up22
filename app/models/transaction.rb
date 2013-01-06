class Transaction < ActiveRecord::Base
  attr_accessible :funded_id, :gift_id, :amount, :description, :checkout_id, :checkout_uri

  belongs_to :funder, class_name: "User"
  belongs_to :funded, class_name: "User"

  validates :funder_id, presence: true
  validates :funded_id, presence: true
end
