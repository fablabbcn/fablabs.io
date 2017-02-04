
namespace :dragonfly do
  desc 'Clear dragonfly uids from db'
  task clear_images: :environment do
    User.update_all(avatar_uid: nil)
    Lab.update_all(avatar_uid: nil, header_uid: nil)
    Organization.update_all(avatar_uid: nil, header_uid: nil)
  end

  task import_thing_photo: :environment do
    Thing.where(photo_uid: nil).find_each do |thing|
      if thing.photo_src.present?
        p thing.id
        p thing.photo_src

        file = Dragonfly.app.fetch_url(thing.photo_src).encode('jpg')
        thing.photo = file.data
        thing.photo_name = "#{thing.name}.jpg"
        thing.save
      end
    end
  end
end

