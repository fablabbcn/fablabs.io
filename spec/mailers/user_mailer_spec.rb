require "spec_helper"

describe UserMailer, type: :mailer do

  let(:user_emails) { ['email@bitsushi.com', 'fallback@example.com'] }

  let(:lab) { FactoryBot.create(:lab) }
  let(:user) { FactoryBot.create(:user, email: user_emails[0], email_fallback: user_emails[1]) }
  let(:employee) { FactoryBot.create(:employee, user: user, lab: lab) }

  %w(
    submitted
    approved
    rejected
    removed
    referee_approved
    referee_rejected
    requested_more_info
    more_info_added
  ).each do |action|
    it "lab_#{action} notification" do
      mail = UserMailer.send("lab_#{action}", lab.id)
      expect(mail.subject).to eq("[#{lab.name}] #{action.capitalize}")
      expect(mail.to).to eq([lab.creator.email])
      expect(mail.from).to eq(["notifications@fablabs.io"])
      if action == "submitted"
        expect(mail.body.encoded).to match("submitting #{@lab}")
      else
        expect(mail.body.encoded).to match("#{@lab}")
      end
    end
  end

  it "employee_approved notification" do
    mail = UserMailer.employee_approved(employee.id)
    expect(mail.subject).to match("Employee Application Approval")
    expect(mail.to).to eq([employee.user.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(lab_url(employee.lab))
  end

  it "welcome" do
    mail = UserMailer.welcome(user.id)
    expect(mail.subject).to include("Confirmation Instructions")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fablabs.io"])
    expect(mail.body.encoded).to match(root_url)
  end

  it "verification" do
    mail = UserMailer.verification(user.id)
    expect(mail.subject).to include("Verification")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["support@fablabs.io"])
    expect(mail.body.encoded).to match(verify_email_url(user.email_validation_hash))
  end

  it "account_recovery_instructions" do
    recovery = FactoryBot.create(:recovery, user: user, email_or_username: [user.email, user.username].sample)
    mail = UserMailer.account_recovery_instructions(user.id)
    expect(mail.subject).to match("Account Recovery Instructions")
    expect(mail.to).to eq(['email@bitsushi.com', 'fallback@example.com'])
    expect(mail.from).to eq(["support@fablabs.io"])
    expect(mail.body.encoded).to match( recovery_url(user.recovery_key) )
  end

  it "account_recovery_instructions_single" do
    simpleuser = FactoryBot.create(:user, email: 'one@example.com')
    recovery = FactoryBot.create(:recovery, user: simpleuser, email_or_username: [simpleuser.email, simpleuser.username].sample)
    mail = UserMailer.account_recovery_instructions(simpleuser.id)
    expect(mail.to).to eq(['one@example.com'])
  end

end
