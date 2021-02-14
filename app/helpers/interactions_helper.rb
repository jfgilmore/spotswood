# frozen_string_literal: true

module InteractionsHelper
  # Handling queries on already preloaded records without running a db query
  # Returns styling for interaction buttons to indicate present selection
  def button_class_value(listing, user_action)
    current_user.interactions.each do |i|
      next unless i.listing_id == listing.id

      (return 'btn btn-dark btn-sm') unless i.user_action == user_action[0]

      return 'btn btn-success btn-sm'
    end
  end

  def interaction_user_alert(action)
    "Awesome you want to: #{action.to_s.humanize}; you need to log in first"
  end

  def interaction_saved_alert(saved, action)
    if saved
      "Awesome your going to: #{action.to_s.humanize}"
    else
      'Something went wrong'
    end
  end
end
