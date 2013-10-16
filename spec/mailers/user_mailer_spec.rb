require "spec_helper"

describe UserMailer do

  let(:lab) { FactoryGirl.create(:lab) }
  let(:user) { FactoryGirl.create(:user) }

  it "lab_submitted notification" do
    mail = UserMailer.lab_submitted(lab)
    mail.subject.should eq("#{lab} submitted")
    mail.to.should eq([lab.creator.email])
    mail.from.should eq(["notifications@fabfoundationworld.org"])
    mail.body.encoded.should match("#{@lab} was submitted")
  end

  it "lab_approved notification" do
    mail = UserMailer.lab_approved(lab)
    mail.subject.should eq("#{lab} approved!")
    mail.to.should eq([lab.creator.email])
    mail.from.should eq(["notifications@fabfoundationworld.org"])
    mail.body.encoded.should match(lab_url(lab))
  end

  it "welcome" do
    mail = UserMailer.welcome(user)
    mail.subject.should eq("Welcome")
    mail.to.should eq([user.email])
    mail.from.should eq(["notifications@fabfoundationworld.org"])
    mail.body.encoded.should match(root_url)
  end

end
