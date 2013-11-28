require 'spec_helper'

describe AdminApplication do
  pending { should belong_to(:lab) }
  pending { should belong_to(:applicant) }
  pending { should validate_presence_of(:lab) }
  pending { should validate_presence_of(:applicant) }
end
