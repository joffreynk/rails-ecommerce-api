class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :message, :rating, presence:true
  validates :message, lenght: {in:10..500}
  validates :rating, numericality => { :only_integer => true }
end
