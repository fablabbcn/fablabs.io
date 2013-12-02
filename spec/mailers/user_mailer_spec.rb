require "spec_helper"

describe UserMailer do

  let(:lab) { FactoryGirl.create(:lab) }
  let(:user) { FactoryGirl.create(:user) }
  let(:employee) { FactoryGirl.create(:employee, user: user, lab: lab) }

  %w(submitted approved rejected removed).each do |action|
    it "lab_#{action} notification" do
      mail = UserMailer.send("lab_#{action}", lab)
      expect(mail.subject).to match("#{lab} #{action.capitalize}")
      expect(mail.to).to eq([lab.creator.email])
      expect(mail.from).to eq(["notifications@fablabs.io"])
      if action == "submitted"
        expect(mail.body.encoded).to match("submitting #{@lab}")
      else
        expect(mail.body.encoded).to match("#{@lab} was #{action}")
      end
    end
  end

  it "employee_approved notification" do
    mail = UserMailer.employee_approved(employee)
    expect(mail.subject).to match("Employee Application Approval")
    expect(mail.to).to eq([employee.user.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(lab_url(employee.lab))
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
    expect(mail.from).to eq(["support@fablabs.io"])
    expect(mail.body.encoded).to match(verify_email_url(user.email_validation_hash))
  end

  it "account_recovery_instructions" do
    recovery = FactoryGirl.create(:recovery, user: user, email_or_username: [user.email, user.username].sample)
    mail = UserMailer.account_recovery_instructions(user)
    expect(mail.subject).to match("Account Recovery Instructions")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["support@fablabs.io"])
    expect(mail.body.encoded).to match( recovery_url(user.recovery_key) )
  end

end
