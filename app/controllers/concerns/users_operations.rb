module UsersOperations

  extend ActiveSupport::Concern

  def search_users(query)
    User.where("first_name LIKE ? or last_name LIKE ? or username LIKE ?", "%#{query}%", "%#{query}%", "#{query}")
  end
end
