require 'digest/sha1'

module ApplicationHelper

  def locale_link_to language, code
    link_to language, {locale: code}, class: ('active' if I18n.locale.to_s == code)
  end

  def gem_count_tag(count)
    content_tag(:span, count, class: 'gem-count') if count > 0
  end

  def backstage?
    controller.class.parent == Backstage
  end

  def favicon url
    domain = URI.parse(url).host
    ['facebook.com','twitter.com','youtube.com','picasaweb.google.com','flickr.com','pinterest.com','github.com','vimeo.com', 'fablabbcn.org'].each do |s|
      if domain.match(/(www\.)?#{s}/)
        return image_tag hocho("http://#{domain}/favicon.ico", "o=t&q=80&d=16x16"), width: 16, height: 16
      end
    end
    fa_icon "link"
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
    return content_tag(:h1, page_title, options.merge(itemprop: "name"))
  end

  def body_classes
    "#{Rails.env} c-#{controller_name} a-#{action_name} #{'backstage' if backstage?}"
  end

end
