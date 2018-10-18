module LabsSearch

  extend ActiveSupport::Concern

  def search_labs(query)
    if query
      Lab.where("slug LIKE ? or name LIKE ?", "%#{query}%", "%#{query.capitalize}%").with_approved_state
    else
      Lab.none
    end
  end
end
