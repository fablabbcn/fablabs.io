# frozen_string_literal: true

module LabsSearch
  extend ActiveSupport::Concern

  ## TODO Find out how to search for the country
  def search_labs(query)
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
      'slug LIKE ? or name LIKE ? or city LIKE ?',
      "%#{query}%",
      "%#{query.capitalize}%",
      "%#{query}%"
    ).with_approved_state
  end

  def match_slug_country(query, country_code)
    Lab.where(
      'slug LIKE ? or name LIKE ? or city LIKE ? or country_code = ?',
      "%#{query}%",
      "%#{query.capitalize}%",
      "%#{query}%",
      country_code.to_s
    ).with_approved_state
  end

  def match_country(query)
    @country = ISO3166::Country.find_country_by_name(query)
    @country&.alpha2
  end
end
