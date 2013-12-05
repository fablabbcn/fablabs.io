require 'digest/sha1'

module ApplicationHelper

  def gem_count_tag(count)
    content_tag(:span, count, class: 'gem-count') if count > 0
  end

  def backstage?
    controller.class.parent == Backstage
  end

  def favicon url
    icon = URI::join(url, 'favicon.ico').to_s
    ['facebook.com','twitter.com','youtube.com','picasaweb.google.com','flickr.com','pinterest.com','github.com','vimeo.com', 'fablabbcn.org'].each do |s|
      if icon.match(/\/\/(www\.)?#{s}\/favicon\.ico/)
        return image_tag hocho(icon, "o=t&q=80&d=16x16"), width: 16, height: 16
      end
    end
    content_tag :div, "", style: "width: 16px; height: 16px; display: inline-block;"
  end

  def hocho(img, options)
    return if img.blank?
    url = "https://davinci.fablabs.io"
    options = options.unpack('H*').first
    img = img.unpack('H*').first
    sig = Digest::SHA1.hexdigest("#{options}#{img}#{ENV['HOCHO_SALT']}")
    [url, options, img, sig].join('/')
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
    url = Rails.env.production? ? "//i.fablabs.io" : "//fugu.dev"
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
