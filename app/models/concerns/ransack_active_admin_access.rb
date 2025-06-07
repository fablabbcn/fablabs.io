module RansackActiveAdminAccess
  extend ActiveSupport::Concern

  class_methods do
    def from_active_admin?
      caller.any? { |line| line.include?("active_admin") }
    end

    def ransack_admin_context?(auth_object)
      from_active_admin? || auth_object == :superadmin
    end
  end
end
