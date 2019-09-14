# frozen_string_literal: true

require 'digest/sha1'
require 'uri'

module ApplicationHelper
  def url_icon(url)
    case url
    when /twitter\.com/
      icon('twitter')
    when /github\.com/
      icon('github')
    when /flickr\.com/
      icon('flickr')
    when /instagram\.com/
      icon('instagram')
    when /bitbucket\.org/
      icon('bitbucket')
    when /dropbox/
      icon('dropbox')
    when /facebook/
      icon('facebook')
    when /plus\.google\.com/
      icon('google-plus')
    when /youtube\.com/
      icon('youtube')
    when /vimeo\.com/
      icon('vimeo-square')
    when /linkedin\.com/
      icon('linkedin')
    else
      icon('link')
    end
  end

  def comments_script(discourse_id)
    %{
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
    %(
    <!-- Begin Cookie Consent plugin by Silktide - http://silktide.com/cookieconsent -->
    <script type="text/javascript">
        window.cookieconsent_options = {"message":"This website uses cookies to ensure you get the best experience on our website","dismiss":"Got it!","learnMore":"More info","link":"/cookie-policy","theme":"dark-bottom"};
    </script>

    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/cookieconsent2/1.0.10/cookieconsent.min.js"></script>
    <!-- End Cookie Consent plugin -->
    ).html_safe
  end

  def locale_link_to(language, code)
    link_to language, { locale: code }, class: ('text-primary' if I18n.locale.to_s == code)
  end

  def gem_count_tag(count)
    content_tag(:span, count, class: 'gem-count') if count > 0
  end

  def backstage?
    controller.class.parent == Backstage
  end

  def player(url)
    begin
      domain = URI.parse(url).host
    rescue URI::InvalidURIError
      return nil
    end
    if /(www\.)?#{'youtube.com'}/.match?(domain)
      query_string = URI.parse(url).query
      parameters = Hash[URI.decode_www_form(query_string)]
      v = parameters['v']
      "<iframe width=\"400\" height=\"315\" src=\"https://www.youtube.com/embed/#{v}\" frameborder=\"0\" allowfullscreen></iframe>"
    elsif /(www\.)?#{'vimeo.com'}/.match?(domain)
      match = url.match(%r{https?://(?:[\w]+\.)*vimeo\.com(?:[/\w]*/?)?/(?<id>[0-9]+)[^\s]*})
      id = match[:id] if match.present?
      "<iframe src=\"https://player.vimeo.com/video/#{id}\" width=\"400\" height=\"225\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
    end
  end

  def hocho(img, options)
    Hocho.hocho(img, options)
  end

  def flash_class(level)
    case level
    when :notice then 'flash alert alert-info'
    when :success then 'flash alert alert-success'
    when :error then 'flash alert alert-danger'
    when :alert then 'flash alert alert-warning'
    else 'flash alert'
    end
  end

  def cropped_image_path(image, dimensions)
    url = Rails.env.production? ? '//i.fablabs.io' : '//fugu.dev'
    "#{url}/images/crop/#{dimensions}/#{image.gsub(%r{https?://}, '')}/image.jpg"
  end

  def cropped_image_tag(image, dimensions, options = {})
    image_tag(
      cropped_image_path(image, dimensions),
      options
    )
  end

  def title(page_title, options = {})
    content_for(:title, page_title.to_s)
    content_tag(:h1, page_title, options.merge(itemprop: 'name'))
  end

  def body_classes
    "#{Rails.env} c-#{controller_name} a-#{action_name} #{'backstage' if backstage?}"
  end

  def google_maps_api_key
    Fablabs::Application.config.google_maps_api_key
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
