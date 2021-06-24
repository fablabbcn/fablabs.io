class LabTagging < ApplicationRecord
  belongs_to :lab
  belongs_to :lab_tag
end
