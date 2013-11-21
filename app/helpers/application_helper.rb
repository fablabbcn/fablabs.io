module ApplicationHelper

  def gem_count_tag(count)
    content_tag(:span, count, class: 'gem-count') if count > 0
  end

  def backstage?
    controller.class.parent == Backstage
  end

  def flash_class(level)
    case level
      when :notice then "flash alert alert-info"
      when :success then "flash alert alert-success"
      when :error then "flash alert alert-danger"
      when :alert then "flash alert alert-warning"
    end
  end

  def cropped_image_path image, dimensions
    url = Rails.env.production? ? "https://i.fablabs.io" : "http://fugu.dev"
    "#{url}/images/crop/#{dimensions}/#{image.gsub(/https?:\/\//, '')}/image.jpg"
  end

  def cropped_image_tag image, dimensions, options={}
    image_tag(
      cropped_image_path(image,dimensions),
      options
    )
  end

  def title(page_title, options={})
    content_for(:title, page_title.to_s)
    return content_tag(:h1, page_title, options)
  end

  def body_classes
    "c-#{controller_name} a-#{action_name} #{'backstage' if backstage?}"
  end

end
