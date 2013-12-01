require "spec_helper"

describe AdminMailer do

  let(:lab) { FactoryGirl.create(:lab) }

  it "lab_submitted notification" do
    admin = FactoryGirl.create(:user, email: 'john@bitsushi.com')
    admin.add_role :admin
    mail = AdminMailer.lab_submitted(lab)
    expect(mail.subject).to eq("#{lab} submitted")
    expect(mail.to).to eq(['john@bitsushi.com'])
    expect(mail.from).to eq(["admin_notifications@fablabs.io"])
    expect(mail.body.encoded).to match("#{backstage_lab_url(lab)}")
  end

end
