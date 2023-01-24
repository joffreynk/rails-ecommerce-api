class User < ApplicationRecord
  has_many: products
  has_many :reviews
  has_many :orders

  validates :firstName, :lastName, :email, :password, :phoneNumber, :address, presence: true, 
  validates :password, :phoneNumber, length :{in: 6..15}, 
end
