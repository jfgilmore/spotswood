# All validations implemented as client side validations
class Category < ApplicationRecord
  has_many :listings
  validates :name, presence: true
end
