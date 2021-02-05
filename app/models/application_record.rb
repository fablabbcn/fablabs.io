class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.country_list_for(labs)
    c = Hash.new(0)
    # upcase so we dont get duplicate labs. Country code ES != es
    labs.map{ |v| c[v[:country_code].upcase] += 1 }
    countries = []
    c.each do |country_code, count|
      if Country[country_code]
        countries.push([Country[country_code].name, country_code, count])
      end
    end
    return countries.sort_alphabetical_by(&:first)
  end

  def country
    ISO3166::Country[country_code]
  end
end
