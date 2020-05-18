class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy

  validates :name, length: { in: 2...40 }
  validates :summary, length: { in: 22...120 }
  validates :location, length: { in: 6...200 }
  validates :cost, numericality: { only_integer: true }
  validate :cannot_be_in_the_past
  validate :image_type

  def cannot_be_in_the_past
    errors.add(:when, 'New events can only happen in the future') unless Time.zone.now.to_i > time.to_i
  end

  def display_size(image)
    return self.images[image].variant(resize_to_fill: [1000, 700, { gravity: 'Center' }]).processed
  end

  def thumbnail(input, size = 50)
    return self.images[input].variant(resize: "#{size}x#{size}!")
  end

  def image_type
    if images.attached?
      images.each do |image|
        if !image.content_type.in?(%('image/jpeg image/jpg image/png image/gif'))
          errors.add(:images, 'Only jpg, png, and gif formats accepted.')
        end
      end
    end
  end
end
# gravity: "center",