# frozen_string_literal: true

module ApplicationHelper
  # Image helpers
  def set_image(image, size = 200)
    image.variant(resize: "#{size}x#{size}!")
  end

  def user_avatar(reference, size = 28)
    if reference.avatar.attached?
      reference.avatar.variant(resize: "#{size}x#{size}!")
    else
      gravatar_image_url(reference, size)
    end
  end

  def gravatar_image_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  # Only application internal assets to be used with this method
  # Returns svg in markup
  def show_svg(path)
    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw(file.read)
    end
  end
end
