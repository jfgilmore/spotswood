module ApplicationHelper

  def user_avatar(user, size=40)
    if user.avatar.attached?
      user.avatar.variant(resize: "#{size}x#{size}")
    else
      user.name[0,1]
    end
  end
end
