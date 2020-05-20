module ListingsHelper
  def user_interaction? listing
    listing.interactions.find_by(user: current_user).present? ? true : false
  end

  def user_interaction listing
    listing.interactions.find_by(user: current_user)
  end

  def class_value listing
    if user_interaction? listing
      'img-thumbnail border border-success shadow-lg p-3 mb-3'
    else
      'img-thumbnail border border-light p-3 mb-3'
    end
  end
end
