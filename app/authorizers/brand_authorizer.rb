class BrandAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    true
  end

  def self.updatable_by?(user)
    true
  end

  def self.readable_by?(user)
    true
  end

end
