class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_one :campaign

  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  attr_accessible :wepay_token, :wepay_id, :wepay_account_id, :wepay_account_uri


  has_many :transactions, foreign_key: "funder_id", dependent: :destroy

  has_many :funded_users, through: :transactions, source: :funded

  has_many :reverse_transactions, foreign_key: "funded_id",
                                   class_name:  "Transaction",
                                   dependent:   :destroy

  has_many :funders, through: :reverse_transactions, source: :funder

  has_many :authentications

def funding?(other_user)
    transactions.find_by_funded_id(other_user.id)
end

def fund!(other_user)
  transactions.create!(funded_id: other_user.id)
end

def unfund!(other_user)
  transactions.find_by_funded_id(other_user.id).destroy
end


def apply_omniauth(omniauth)
  authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
end

def password_required?
  (authentications.empty? || !password.blank?) && super
end




end
