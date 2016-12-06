class LabOrganization < ActiveRecord::Base
  belongs_to :lab, touch: true
  belongs_to :organization, touch: true

  validates :lab_id, uniqueness: { scope: :organization_id }
end
