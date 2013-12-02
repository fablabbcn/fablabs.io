class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  before_save :password_protect_superadmin

  scopify

private

  def password_protect_superadmin
    name != "superadmin"
  end

end
