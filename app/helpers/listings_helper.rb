# frozen_string_literal: true

module ListingsHelper
  def user_interaction?(listing)
    listing.interactions.find_by(user_id: current_user.id).present? ? true : false
  end

  def user_interaction(listing)
    listing.interactions.find_by(user_id: current_user.id)
  end

  def class_value(listing)
    if user_interaction? listing
      'img-thumbnail border border-success shadow-lg p-3 mb-3'
    else
      'img-thumbnail border border-light p-3 mb-3'
    end
  end
end
