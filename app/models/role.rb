class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  scopify

  AVAILABLE = [ROLE_ADMIN = 'admin', ROLE_SUPERADMIN = 'superadmin']

  private

  def self.ransackable_attributes(auth_object = nil)
    ["name", "resource_id", "resource_type"]
  end

end
