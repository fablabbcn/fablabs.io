
namespace :dragonfly do
  desc 'Clear dragonfly uids from db'
  task clear_images: :environment do
    User.update_all(avatar_uid: nil)
    Lab.update_all(avatar_uid: nil, header_uid: nil)
    Organization.update_all(avatar_uid: nil, header_uid: nil)
    Thing.update_all(photo_uid: nil)
    Document.update_all(photo_uid: nil)
  end

  task import_documents: :environment do
    Document.where(photo_uid: nil).find_each do |doc|
      if doc.image.present?
        p doc.id
        p doc.image.url(:large)

        file = Dragonfly.app.fetch_url(doc.image.url(:large)).encode('jpg')
        doc.photo = file.data
        doc.photo_name = "#{doc.id}.jpg"
        doc.save
      end
    end
  end
end

