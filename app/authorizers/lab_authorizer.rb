class LabAuthorizer < ApplicationAuthorizer

  def self.readable_by?(user)
    true
  end

  def self.deletable_by?(user)
    true
    # user.email == "john@bitsushi.com"
  end

  def self.creatable_by?(user)
    true
    # user.email == "john@bitsushi.com"
  end

end
