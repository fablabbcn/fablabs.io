module Doorkeeper
  class Application < ApplicationRecord
    include ::Doorkeeper::Orm::ActiveRecord::Mixins::Application

    def self.ransackable_attributes(auth_object = nil)
      %w[id name uid redirect_uri scopes confidential created_at updated_at owner_type]
    end

    def self.ransackable_associations(auth_object = nil)
      %w[access_grants access_tokens]
    end
  end
end