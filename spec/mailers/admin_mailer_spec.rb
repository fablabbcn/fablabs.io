require "spec_helper"

describe AdminMailer do

  let(:lab) { FactoryGirl.create(:lab) }
  let(:user) { FactoryGirl.create(:user) }
  let(:employee) { FactoryGirl.create(:employee, user: user, lab: lab) }
  let(:admin) { FactoryGirl.create(:user, email: 'john@bitsushi.com') }

  before(:each) do
    admin.add_role :admin
  end

  it "lab_submitted notification" do
    mail = AdminMailer.lab_submitted(lab.id)
    expect(mail.subject).to eq("[#{lab}] submitted")
    expect(mail.to).to eq(['john@bitsushi.com'])
    expect(mail.from).to eq(["admin_notifications@fablabs.io"])
    expect(mail.body.encoded).to match("#{backstage_lab_url(lab)}")
  end

  it "employee_applied notification" do
    mail = AdminMailer.employee_applied(employee.id)
    expect(mail.subject).to eq("[#{lab.name}] Employee Application")
    expect(mail.to).to eq(lab.admins.map(&:email))
    expect(mail.from).to eq(["admin_notifications@fablabs.io"])
    expect(mail.body.encoded).to match(lab_employees_url(lab))
  end

end
