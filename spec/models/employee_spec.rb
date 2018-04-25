require 'spec_helper'

describe Employee, type: :model  do
  it { should belong_to(:user) }
  it { should belong_to(:lab) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:lab) }
  it { should validate_presence_of(:job_title) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:lab_id) }

  it "is valid" do
    expect(FactoryGirl.create(:employee)).to be_valid
  end

  describe "states" do
    it "is initially unverified" do
      lab = FactoryGirl.create(:lab)
      employee = FactoryGirl.create(:employee, lab: lab)
      expect(employee).to be_unverified
    end

    it "can be approved" do
      lab = FactoryGirl.create(:lab)
      employee = FactoryGirl.create(:employee, lab: lab)
      expect(employee.user).to_not have_role(:admin, lab)
      employee.approve!
      expect(employee.user).to have_role(:admin, lab)
      expect(employee).to be_approved
    end

    it "auto approves lab admins" do
      user = FactoryGirl.create(:user)
      lab = FactoryGirl.create(:lab)
      user.add_role :admin, lab
      employee = FactoryGirl.create(:employee, lab: lab, user: user)
      expect(employee).to be_approved
    end
  end

  it "can be deleted" do
    lab = FactoryGirl.create(:lab)
    employee = FactoryGirl.create(:employee, lab: lab)
    employee.approve!
    expect(employee.user).to have_role(:admin, lab)
    employee.destroy
    expect(employee.user).to_not have_role(:admin, lab)
  end

  describe ".active" do
    let(:lab) { FactoryGirl.create(:lab) }

    it "returns approved employees" do
      employee = FactoryGirl.create(:employee, lab: lab)
      expect(lab.employees.active).to_not include(employee)
    end

    it "ignores unverified employees" do
      employee = FactoryGirl.create(:employee, lab: lab)
      employee.approve!
      expect(lab.employees.active).to include(employee)
    end
  end

end
