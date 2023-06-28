# frozen_string_literal: true

module LabsSearch
  extend ActiveSupport::Concern

  ## TODO Find out how to search for the country
  def search_labs(query)
    if query
      @country = match_country(query)
      @country && match_slug_country(query, @country).with_approved_state || match_slug(query).with_approved_state
    else
      Lab.none
    end
  end


  def search_labs_admin(query)
    if query
      @country = match_country(query)
      @country && match_slug_country(query, @country) || match_slug(query)
    else
      Lab.none
    end
  end


  private

  def match_slug(query)
    Lab.where(
      'slug LIKE ? or UPPER(name) LIKE UPPER(?) or UPPER(city) LIKE UPPER(?) or UPPER(county) LIKE UPPER(?)',
      "%#{query}%",
      "%#{query}%",
      "%#{query}%",
      "%#{query}%"
    ).with_approved_state
  end

  def match_slug_country(query, country_code)
    Lab.where(
      'slug LIKE ? or UPPER(name) LIKE UPPER(?) or UPPER(city) LIKE UPPER(?) or UPPER(county) LIKE UPPER(?) or UPPER(country_code) = UPPER(?)',
      "%#{query}%",
      "%#{query}%",
      "%#{query}%",
      "%#{query}%",
      country_code.to_s
    )
  end

  def match_country(query)
    @country = ISO3166::Country.find_country_by_any_name(query)
    @country&.alpha2
  end
end
