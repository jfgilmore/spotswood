class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :name, length: { in: 2...40 }
  validates :summary, length: { in: 22...120 }
  validates :location, length: { in: 6...200 }
  validates :cost, numericality: { only_integer: true }
  validate :cannot_be_in_the_past

  def cannot_be_in_the_past
    if Time.now.to_i > time.to_i
      errors.add(:when, 'New events can only happen in the future')
    end
  end
end
