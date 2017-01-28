
namespace :dragonfly do
  task user_avatar_import: :environment do
    User.where(avatar_uid: nil).find_each do |user|
      if user.avatar_src.present?
        p user.id
        p user.avatar_src

        begin
          file = Dragonfly.app.fetch_url(user.avatar_src).encode('jpg')
          user.avatar = file.data
          user.avatar_name = "#{user.id}.jpg"
          user.save(validate: false)
        rescue => e
          p e
        end
      end
    end
  end
end

