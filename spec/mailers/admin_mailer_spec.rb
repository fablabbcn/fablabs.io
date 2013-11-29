require "spec_helper"

describe AdminMailer do

  let(:lab) { FactoryGirl.create(:lab) }

  it "lab_submitted notification" do
    admin = FactoryGirl.create(:user, email: 'john@bitsushi.com')
    admin.add_role :admin
    mail = AdminMailer.lab_submitted(lab)
    mail.subject.should eq("#{lab} submitted")
    mail.to.should eq(['john@bitsushi.com'])
    mail.from.should eq(["admin_notifications@fablabs.io"])
    mail.body.encoded.should match("#{backstage_lab_url(lab)}")
  end

end
