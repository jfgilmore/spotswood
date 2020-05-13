module ApplicationHelper

  def user_avatar(user, size=28)
    if user.avatar.attached?
      user.avatar.variant(resize: "#{size}x#{size}")
    else
      gravatar_image_url(user)
    end
  end

  def gravatar_image_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end
end
