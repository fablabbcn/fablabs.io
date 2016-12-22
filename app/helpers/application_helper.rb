require 'digest/sha1'
require 'uri'

module ApplicationHelper

  def comments_script(discourse_id)
    %Q{
      <div id='discourse-comments'></div>
      <script type="text/javascript">
        DiscourseEmbed = { discourseUrl: '#{Figaro.env.discourse_endpoint}',
                          topicId: #{discourse_id} };

        (function() {
          var d = document.createElement('script'); d.type = 'text/javascript'; d.async = true;
          d.src = DiscourseEmbed.discourseUrl + 'javascripts/embed.js';
          (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(d);
        })();
      </script>
    }.html_safe
  end

  def cookie_policy_script
    %Q{
    <!-- Begin Cookie Consent plugin by Silktide - http://silktide.com/cookieconsent -->
    <script type="text/javascript">
        window.cookieconsent_options = {"message":"This website uses cookies to ensure you get the best experience on our website","dismiss":"Got it!","learnMore":"More info","link":"/cookie-policy","theme":"dark-bottom"};
    </script>

    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/1.0.10/cookieconsent.min.js"></script>
    <!-- End Cookie Consent plugin -->
    }.html_safe
  end

  def locale_link_to language, code
    link_to language, {locale: code}, class: ('active' if I18n.locale.to_s == code)
  end

  def gem_count_tag(count)
    content_tag(:span, count, class: 'gem-count') if count > 0
  end

  def backstage?
    controller.class.parent == Backstage
  end

  def player url
    domain = URI.parse(url).host
    if domain.match(/(www\.)?#{'youtube.com'}/)
      query_string = URI.parse(url).query
      parameters = Hash[URI.decode_www_form(query_string)]
      v = parameters['v']
      "<iframe width=\"400\" height=\"315\" src=\"https://www.youtube.com/embed/#{v}\" frameborder=\"0\" allowfullscreen></iframe>"
    elsif domain.match(/(www\.)?#{'vimeo.com'}/)
      match = url.match(/https?:\/\/(?:[\w]+\.)*vimeo\.com(?:[\/\w]*\/?)?\/(?<id>[0-9]+)[^\s]*/)
      id = match[:id] if match.present?
      "<iframe src=\"https://player.vimeo.com/video/#{id}\" width=\"400\" height=\"225\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
    else
      nil
    end
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

  def markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      filter_html: true,
      prettify: true,
      safe_links_only: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true)
    md.render(text).html_safe
  end

  def restricted_markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      filter_html: true,
      no_images: true,
      no_links: true,
      no_style: true,
      escape_html: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true)
    md.render(text).html_safe
  end


end
