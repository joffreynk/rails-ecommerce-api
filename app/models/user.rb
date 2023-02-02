class User < ApplicationRecord
  has_one_attached :profile_picture
  has_many :products
  has_many :reviews
  has_many :orders

  validates :firstName, :lastName, :email, :password_digest, :phoneNumber, :address, presence: true 
  validates :password_digest, :phoneNumber, length: {in: 6..15}
  validates :email, uniqueness: true

  def profile_picture_url
    Rails.application.routes.url_helpers.url_for(profile_picture) if profile_picture.attached
  end
end
