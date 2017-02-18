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
      p "org - #{org.id}"
      attrs.each do |attr|
        url = org.send(attr)
        if url.present?
          unless link = org.links.create(url: url)
            p link.errors
          end
        end
      end
    end

    Project.find_each do |pro|
      p "pro - #{pro.id}"
      attrs.each do |attr|
        url = pro.send(attr)
        if url.present?
          unless link = pro.links.create(url: url)
            p link.errors
          end
        end
      end
    end
  end
end
