class Listing < ApplicationRecord
  belongs_to :user
  validates :name
end
