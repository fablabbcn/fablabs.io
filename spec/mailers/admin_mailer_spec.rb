require "spec_helper"

describe AdminMailer do

  let(:lab) { FactoryGirl.create(:lab) }

  it "lab_submitted notification" do
    mail = AdminMailer.lab_submitted(lab)
    mail.subject.should eq("#{lab} submitted")
    mail.to.should eq(['john@bitsushi.com'])
    mail.from.should eq(["admin_notifications@fabfoundationworld.org"])
    mail.body.encoded.should match("#{backstage_lab_url(lab)}")
  end

end
