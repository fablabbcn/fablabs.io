require 'httparty'

namespace :fixes do

  desc "Any labs without GEO coordinates, fill from address"
  task labsgeo: :environment do

    ARGV.each { |a| task a.to_sym do ; end }

    if ARGV[1].present?
      lab = Lab.find(ARGV[1].to_i)
      update_geo_lab(lab)
    else
      labs = Lab.where(latitude: nil)
                .where(workflow_state: 'approved')
                .order('created_at DESC')
                .limit(50)

      STDOUT.puts "You are about to run through #{labs.length} labs. Are you sure? (y/n)"

      begin
        input = STDIN.gets.strip.downcase
      end until %w(y n).include?(input)

      if input != 'y'
        STDOUT.puts "Opsy, stopping."
        next
      end

      labs.each do |lab|
        update_geo_lab(lab)
      end
    end

    Rails.cache.clear
  end
end

def update_geo_lab(lab)

  STDOUT.puts "Doing #{lab.name}"

  if !lab.address_1.present? || !lab.city.present? || !lab.country_code.present?
    STDOUT.puts "NO address_1 or City !!"
    return
  end

  query_lines = []
  query_lines << lab.address_1
  query_lines << lab.address_2 if lab.address_2.present?
  query_lines << lab.city
  query_lines << lab.county if lab.county.present?
  query_lines << lab.subregion if lab.subregion.present?
  query_lines << lab.region if lab.region.present?
  query_lines << lab.postal_code if lab.postal_code.present?
  query_lines << lab.country_code

  querytext = query_lines.join(', ')

  STDOUT.puts querytext

  result = false
  loop do
    result = fetch_place(querytext)
    break if result

    querytext = ask_for_new_text()

    if querytext.empty?
      return
    end
  end

  puts "FOUND: #{result['geometry']['location']['lat']}"
  puts result

  lab.update_columns(latitude: result['geometry']['location']['lat'], longitude: result['geometry']['location']['lng'])
end

def fetch_place(querytext)

  response = HTTParty.get('https://maps.googleapis.com/maps/api/place/findplacefromtext/json',
    query: {
      key: ENV['GOOGLE_PLACES_API_KEY'],
      input: querytext,
      fields: 'formatted_address,name,geometry',
      inputtype: 'textquery',
    },
  )

  data = JSON.parse(response.body)

  if !data.key?('candidates') || !data['candidates'].is_a?(Array)
    warn "No results returned."
    return false
  end

  if data['candidates'].empty?
    warn "Empty results returned."
    return false
  end

  if data['candidates'].length > 1
    warn "More than one result, skipping..."
    return false
  end

  return data['candidates'].first
end

def ask_for_new_text()

  STDOUT.puts "Would you like to try a specific text? (empty for no)"

  return STDIN.gets.strip
end