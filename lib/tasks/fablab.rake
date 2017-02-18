namespace :fablab do
  task set_referees: :environment do
    Lab.approved_referees.each do |lab|
      lab.update_column(:is_referee, true)
    end
  end

  task import_links: :environment do
      attrs = ["web",
      "github",
      "drive",
      "twitter",
      "flickr",
      "instagram",
      "bitbucket",
      "dropbox",
      "facebook",
      "googleplus",
      "youtube",
      "vimeo"]

    Organization.find_each do |org|
      attrs.each do |attr|
        url = org.send(attr)
        if url.present?
          org.links.create!(url: url)
        end
      end
    end
  end
end
