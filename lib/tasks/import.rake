require 'csv'

def slugify slug
  slug.downcase.gsub(/[^a-z0-9]+/i,'')
end

def get_state state
  case state
    when "new"
      "unverified"
    when "approved"
      "approved"
    else
      raise "state not found"
  end
end

namespace :csv do
  namespace :import do

    task :users => :environment do
      User.delete_all
      counter = 0
      p "Have you disabled has_secure_password?"
      CSV.foreach('csv/users.csv', :headers => true) do |r|
        # MyModel.create!(row.to_hash)
        begin
          user = User.create!({
            id: r['id'],
            first_name: r['first_name'],
            last_name: r['last_name'],
            username: slugify("#{r['first_name']}#{r['last_name']}"),
            email: r['email'],
            password_digest: r['password_digest'],
            phone: r['phone'],
            city: r['city'],
            country_code: r['country_code'],
            url: r['url'],
            dob: r['dob'],
            avatar_src: r['avatar'],
            bio: r['bio'],
            created_at: DateTime.parse(r['created_at'])
          })
        rescue ActiveRecord::RecordInvalid => e
          p "Error #{counter+=1} - ##{r['id']} #{r['email']}"
          p e
        end
      end
    end

    task :labs => :environment do
      Lab.delete_all
      Link.delete_all
      counter = 0
      CSV.foreach('csv/labs2.csv', :headers => true) do |r|
        begin
          lab = Lab.create!({
            id: r['id'],
            name: r['name'],
            slug: slugify(r['slug']),

            workflow_state: 'approved',
            # FIND DIFFERENT STATES
            workflow_state: get_state(r['state']),
            kind: r['kind'],
            ancestry: r['ancestry'],
            description: r['description'],
            blurb: r['description'],
            phone: r['phone'],
            email: r['email'],
            tools_list: r['facilities'],
            address_1: r['street_address_1'],
            address_2: r['street_address_2'],
            county: r['street_address_3'],
            city: r['city'],
            postal_code: r['postal_code'],
            country_code: r['country_code'],
            latitude: r['latitude'],
            longitude: r['longitude'],
            address_notes: r['address_notes'],
            application_notes: r['application_notes'],
            header_image_src: r['avatar_src'],
            creator_id: r['creator_id'],
            created_at: DateTime.parse(r['created_at'])
          })

          if r['urls'].present?
            lab.links.delete_all
            r['urls'].lines.map(&:chomp).each do |url|
              lab.links.create!(url: url)
            end
          end
          # lab.reverse_geocode
          # sleep(1)
        rescue ActiveRecord::RecordInvalid => e
          p "Error #{counter+=1} - #{r['name']}"
          p e
        end
      end
    end

  end
end
