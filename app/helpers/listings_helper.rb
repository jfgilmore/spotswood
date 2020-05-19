module ListingsHelper
  def user_interaction? listing
    listing.interactions.find_by(user: current_user).present? ? true : false
  end

  def user_interaction listing
    listing.interactions.find_by(user: current_user)
  end

  def class_value listing
    if user_interaction? listing
      'img-thumbnail border border-success'
    else
      'img-thumbnail border border-light'
    end
  end
end
