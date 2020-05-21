# frozen_string_literal: true

module ListingsHelper
  # Handling queries on already preloaded records without running a db query
  # Returns either the Interaction record when the listing matches the user
  def user_interaction(listing)
    (return false) if current_user.nil?

    listing.interactions.each do |i|
      i.user_id == current_user.id ? (return i) : false
    end
    false
  end

  # Returns stuling for index thumbnails for already interacted with listings
  def thumbnail_class_value(listing)
    if user_interaction(listing)
      'img-thumbnail border border-success shadow-lg p-3 mb-3'
    else
      'img-thumbnail border border-light p-3 mb-3'
    end
  end
end
