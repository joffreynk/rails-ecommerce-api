class User < ApplicationRecord
  has_many :products
  has_many :reviews
  has_many :orders

  validates :firstName, :lastName, :email, :password_digest, :phoneNumber, :address, presence: true 
  validates :password_digest, :phoneNumber, length: {in: 6..15}
  validates :email, uniqueness: true
end
