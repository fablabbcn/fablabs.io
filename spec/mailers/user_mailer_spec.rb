require "spec_helper"

describe UserMailer do

  let(:lab) { FactoryGirl.create(:lab) }
  let(:user) { FactoryGirl.create(:user) }

  it "lab_submitted notification" do
    mail = UserMailer.lab_submitted(lab)
    mail.subject.should eq("#{lab} submitted")
    mail.to.should eq([lab.creator.email])
    mail.from.should eq(["notifications@fablabs.io"])
    mail.body.encoded.should match("#{@lab} was submitted")
  end

  it "lab_approved notification" do
    mail = UserMailer.lab_approved(lab)
    mail.subject.should eq("#{lab} approved")
    mail.to.should eq([lab.creator.email])
    mail.from.should eq(["notifications@fablabs.io"])
    mail.body.encoded.should match(lab_url(lab))
  end

  pending "employee_applied notification" do
    mail = UserMailer.employee_applied(lab,employee)
    mail.subject.should eq("#{employee} applied as employee at #{lab}")
    # mail.to.should eq(lab.employees.)
    mail.from.should eq(["notifications@fablabs.io"])
    mail.body.encoded.should match(lab_url(lab))
  end

  it "lab_rejected notification" do
    mail = UserMailer.lab_rejected(lab)
    mail.subject.should eq("#{lab} rejected")
    mail.to.should eq([lab.creator.email])
    mail.from.should eq(["notifications@fablabs.io"])
  end

  it "welcome" do
    mail = UserMailer.welcome(user)
    mail.subject.should include("Confirmation Instructions")
    mail.to.should eq([user.email])
    mail.from.should eq(["notifications@fablabs.io"])
    mail.body.encoded.should match(root_url)
  end

  it "verification" do
    mail = UserMailer.verification(user)
    mail.subject.should include("Verification")
    mail.to.should eq([user.email])
    mail.from.should eq(["notifications@fablabs.io"])
    mail.body.encoded.should match(verify_email_url(user.email_validation_hash))
  end

  it "account_recovery_instructions" do
    recovery = FactoryGirl.create(:recovery, user: user, email_or_username: [user.email, user.username].sample)
    mail = UserMailer.account_recovery_instructions(user)
    mail.subject.should eq("Account Recovery Instructions")
    mail.to.should eq([user.email])
    mail.from.should eq(["support@fablabs.io"])
    mail.body.encoded.should match( recovery_url(user.recovery_key) )
  end

end
