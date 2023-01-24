class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { :in => 10...500}
end
