# frozen_string_literal: true

module InteractionsHelper
  def button_class_value(listing, user_action)
    if current_user.interactions.find_by(listing_id: listing.id).user_action == user_action[0]
      'btn btn-success btn-sm'
    else
      'btn btn-dark btn-sm'
    end
  end
end
