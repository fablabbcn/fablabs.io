module ApplicationHelper

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  # def cropped_image_path image, dimensions
  #   "http://fugu.johnre.es/images/crop/#{dimensions}/#{image.gsub(/https?:\/\//, '')}.jpg"
  # end

  # def cropped_image_tag image, dimensions, options={}
  #   image_tag(
  #     cropped_image_path(image,dimensions),
  #     options
  #   )
  # end

  def title(page_title, options={})
    content_for(:title, page_title.to_s)
    return content_tag(:h1, page_title, options)
  end

end
