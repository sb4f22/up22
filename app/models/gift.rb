class Gift < ActiveRecord::Base
  attr_accessible :name, :description, :stock, :price, :campaign_id

  belongs_to :campaign




end
