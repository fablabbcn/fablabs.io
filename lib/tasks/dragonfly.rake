
namespace :dragonfly do
  task avatar_import: :environment do
    Lab.where(avatar_uid: nil).find_each do |lab|
      if lab.avatar_src.present?
        p lab.id
        p lab.avatar_src

        file = Dragonfly.app.fetch_url(lab.avatar_src).encode('jpg')
        lab.avatar = file.data
        lab.avatar.name = "#{lab.name}.jpg"
        lab.save
      end
    end
  end
end
