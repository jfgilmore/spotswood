module ListingsHelper
  def user_interaction? listing
    listing.interactions.find_by(user: current_user).present? ? true : false
  end

  def user_interaction listing
    listing.interactions.find_by(user: current_user)
  end
end
