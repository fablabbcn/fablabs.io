
namespace :dragonfly do
  task lab_header_import: :environment do
    Lab.where(header_uid: nil).find_each do |lab|
      if lab.header_image_src.present?
        p lab.id
        p lab.header_image_src

        file = Dragonfly.app.fetch_url(lab.header_image_src).encode('jpg')
        lab.avatar = file.data
        lab.avatar.name = "#{lab.name}.jpg"
        lab.save
      end
    end
  end

end

