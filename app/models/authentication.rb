class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid, :email, :name

  belongs_to :user
end
