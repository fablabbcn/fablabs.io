
namespace :dragonfly do
  desc 'Clear dragonfly uids from db'
  task clear_images: :environment do
    User.update_all(avatar_uid: nil)
    Lab.update_all(avatar_uid: nil, header_uid: nil)
    Organization.update_all(avatar_uid: nil, header_uid: nil)
  end

  task orgs_import: :environment do
    Organization.where(header_uid: nil).find_each do |org|
      if org.header_image_src.present?
        p org.id
        p org.header_image_src

        file = Dragonfly.app.fetch_url(org.header_image_src).encode('jpg')
        org.header = file.data
        org.header_name = "#{org.name}.jpg"
        org.save
      end
    end

    Organization.where(avatar_uid: nil).find_each do |org|
      if org.avatar_src.present?
        p org.id
        p org.avatar_src

        file = Dragonfly.app.fetch_url(org.avatar_src).encode('jpg')
        org.avatar = file.data
        org.avatar_name = "#{org.name}.jpg"
        org.save
      end
    end
  end
end

