module UsersOperations
  extend ActiveSupport::Concern

  def search_users(query)
    User.where("first_name iLIKE ? or last_name iLIKE ? or username iLIKE ?", "%#{query}%", "%#{query}%", query.to_s)
      .where(workflow_state: :verified)
  end
end
