module LabsSearch

  extend ActiveSupport::Concern

  def search_labs(query)
    Lab.where("slug LIKE ? or name LIKE ?", "%#{query}%", "%#{query.capitalize}%").with_approved_state
  end
end
