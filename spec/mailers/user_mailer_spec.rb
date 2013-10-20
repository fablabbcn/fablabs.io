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
    mail.subject.should eq("#{lab} approved")
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

  it "account_recovery_instructions" do
    recovery = FactoryGirl.create(:recovery, user: user, email: user.email)
    mail = UserMailer.account_recovery_instructions(user)
    mail.subject.should eq("Account Recovery Instructions")
    mail.to.should eq([user.email])
    mail.from.should eq(["support@fabfoundationworld.org"])
    mail.body.encoded.should match( recovery_url(user.recovery_key) )
  end

end
