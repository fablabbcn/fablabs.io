# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.fablabs.io"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host

    add labs_path, :priority => 0.7, :changefreq => 'daily'
    Lab.find_each do |lab|
      add lab_path(lab, { locale: nil }), :lastmod => lab.updated_at
    end
end
