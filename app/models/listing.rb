class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  enum category: %i[sharing caring produce fundraising sale]

  validate :image_type
  validate :cannot_be_in_the_past
  validates :at_time, presence: true
  validates :name, length: { in: 2...40 }
  validates :summary, length: { in: 22...120 }
  validates :location, length: { in: 6...200 }
  validates :cost, numericality: { only_integer: true }

  # Validation helpers
  def cannot_be_in_the_past
    errors.add(:at_time, 'New events can only happen in the future') unless Time.zone.now.to_i < at_time.to_i
  end

  def image_type
    images.each do |image|
      errors.add(:images, 'Only jpeg, jpg, png, and gif formats accepted') unless image.content_type.in?(%('image/jpeg image/jpg image/png image/gif'))
    end
  end

  # Image helpers
  def display_size(image)
    return self.images[image].variant(resize_to_fill: [1200, 900, { gravity: 'Northwest' }]).processed
  end

  def thumbnail(input, size = 50)
    return self.images[input].variant(resize: "#{size}x#{size}!")
  end

  def self.search(search)
    where('name LIKE ? OR summary LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
