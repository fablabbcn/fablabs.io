class LabTagging < ApplicationRecord
  belongs_to :lab
  belongs_to :lab_tag

  def self.ransackable_attributes(auth_object = nil)
    column_names
  end
end
