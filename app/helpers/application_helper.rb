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
    file_path = "app/assets/images/#{path}"
    if File.exist?(file_path)
      sanitize(File.read(file_path),
               {
                 tags: %w[svg path g], attributes: %w[xmlns enable-background fill viewbox height width d g]
               })
    else
      logger.warn "SVG_MISSING: #{file_path} not located"
      "#{path} not found"
    end
  end
end
