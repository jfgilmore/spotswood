# frozen_string_literal: true

class Listing < ApplicationRecord
  # All validations implemented as client side validations
  scope :filter_by_category, ->(category) { where category_id: category }

  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :interactions, dependent: :destroy
  belongs_to :category

  validate :image_type
  validate :cannot_be_in_the_past
  validates :at_time, presence: true
  validates :images, presence: true
  validates :name, length: { in: 2...40 }
  validates :summary, length: { in: 22...120 }
  validates :location, length: { in: 6...200 }
  validates :cost, numericality: { only_integer: true }
  validates :category, presence: true

  # Validation helpers
  def cannot_be_in_the_past
    errors.add(:at_time, 'New events can only happen in the future') unless Time.zone.now.to_i < at_time.to_i
  end

  def image_type
    images.each do |image|
      unless image.content_type.in?(%('image/jpeg image/jpg image/png
        image/gif'))
        errors.add(:images, 'Only jpeg, jpg, png, and gif formats accepted')
      end
    end
  end

  # Image helpers
  def display_size(image)
    images[image].variant(resize_to_fill: [1200, 900, {
                            gravity: 'Northwest'
                          }]).processed
  end

  def thumbnail(input, size = 50)
    images[input].variant(resize: "#{size}x#{size}!")
  end

  def self.search(params)
    where('listings.name LIKE ? OR listings.summary LIKE ?',
          "%#{params[:search]}%", "%#{params[:search]}%")
  end
end
