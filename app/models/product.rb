class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews

  validates :name, :description, :price, presence:true
  validates :name, length:{ minimum: 5}
  validates :price, numeracity:true,
end
