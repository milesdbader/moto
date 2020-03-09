module ApplicationHelper
  def touch_device?
    user_agent = request.headers["HTTP_USER_AGENT"]
    user_agent.present? && user_agent =~ /\b(Android|iPhone|iPad|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook)\b/i
  end

  def display_avatar(user, attributes = {})
    if user.photo.attached?
      # cl_image their photo
      cl_image_tag user.photo.key,
        width: attributes[:size],
        height: attributes[:size],
        crop: "fill",
        cloud_name: "dtrwqimx6",
        class: attributes[:class],
        style: attributes[:style],
        alt: attributes[:alt],
        data: attributes[:data]
    else
      # import missing_avatar
      image_tag "missing_avatar.png",
        width: attributes[:size],
        height: attributes[:size],
        class: attributes[:class],
        style: attributes[:style],
        alt: attributes[:alt],
        data: attributes[:data]
    end
  end
end
