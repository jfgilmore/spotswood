class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :name, length: { in: 2...40 }
  validates :summary, length: { in: 22...120 }
  validates :location, length: { in: 6...200 }
  validates :cost, numericality: { only_integer: true }
  validate :cannot_be_in_the_past

  has_many_attached :images, dependent: :destroy

  def cannot_be_in_the_past
    errors.add(:when, 'New events can only happen in the future') unless Time.now.to_i > time.to_i

  end
end
