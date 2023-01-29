class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :shippingLocation, :numberOfItems, :totalPrice, presence:true
  validates :totalPrice, numericality:true
  validates :numberOfItems, numericality: { only_integer: true }
end
