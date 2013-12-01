require "spec_helper"

describe UserMailer do

  let(:lab) { FactoryGirl.create(:lab) }
  let(:user) { FactoryGirl.create(:user) }
  let(:employee) { FactoryGirl.create(:employee, user: user, lab: lab) }

  it "lab_submitted notification" do
    mail = UserMailer.lab_submitted(lab)
    expect(mail.subject).to eq("#{lab} submitted")
    expect(mail.to).to eq([lab.creator.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match("#{@lab} was submitted")
  end

  it "lab_approved notification" do
    mail = UserMailer.lab_approved(lab)
    expect(mail.subject).to eq("#{lab} approved")
    expect(mail.to).to eq([lab.creator.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(lab_url(lab))
  end

  it "employee_approved notification" do
    mail = UserMailer.employee_approved(employee)
    expect(mail.subject).to eq("employee")
    expect(mail.to).to eq([employee.user.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(lab_url(employee.lab))
  end

  pending "employee_applied notification" do
    mail = UserMailer.employee_applied(lab,employee)
    expect(mail.subject).to eq("#{employee} applied as employee at #{lab}")
    # mail.to.should eq(lab.employees.)
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(lab_url(lab))
  end

  it "lab_rejected notification" do
    mail = UserMailer.lab_rejected(lab)
    expect(mail.subject).to eq("#{lab} rejected")
    expect(mail.to).to eq([lab.creator.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
  end

  it "welcome" do
    mail = UserMailer.welcome(user)
    expect(mail.subject).to include("Confirmation Instructions")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(root_url)
  end

  it "verification" do
    mail = UserMailer.verification(user)
    expect(mail.subject).to include("Verification")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(verify_email_url(user.email_validation_hash))
  end

  it "account_recovery_instructions" do
    recovery = FactoryGirl.create(:recovery, user: user, email_or_username: [user.email, user.username].sample)
    mail = UserMailer.account_recovery_instructions(user)
    expect(mail.subject).to eq("Account Recovery Instructions")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["support@fablabs.io"])
    expect(mail.body.encoded).to match( recovery_url(user.recovery_key) )
  end

end
