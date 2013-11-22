require 'csv'

namespace :import do
  task :labs => :environment do
    CSV.foreach('labs.csv', :headers => false) do |row|
      # MyModel.create!(row.to_hash)
      p row
      Lab.create(name: row[1], creator: User.first, description: row[5], address_1: row[10], country_code: row[15], slug: row[2])
    end
  end
end
