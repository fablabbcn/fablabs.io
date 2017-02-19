namespace :fablab do
  task set_referees: :environment do
    Lab.approved_referees.each do |lab|
      lab.update_column(:is_referee, true)
    end
  end

  task generate_slugs: :environment do
    User.where(slug: nil).find_each do |user|
      user.save
      p "user: #{user.id} - #{user.slug}"
    end

    Project.where(slug: nil).find_each do |pro|
      pro.save
      p "project: #{pro.id} - #{pro.slug}"
    end

    Thing.where(slug: nil).find_each do |thing|
      thing.save
      p "thing: #{thing.id} - #{thing.slug}"
    end

  end
end
