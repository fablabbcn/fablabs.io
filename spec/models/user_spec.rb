require 'spec_helper'

describe User, type: :model  do

  let(:user) { FactoryBot.create(:user) }
  let(:lab) { FactoryBot.create(:lab)}

  it { should have_one(:coupon) }
  it { should have_many(:academics) }
  it { should have_many(:created_events) }
  it { should have_many(:created_labs) }
  it { should have_many(:comments) }
  it { should have_many(:discussions) }
  it { should have_many(:recoveries) }
  it { should have_many(:role_applications) }
  it { should have_many(:employees) }

  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  # it { should belong_to(:admin_applications) }

  it "is valid" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  describe "states" do

    it "has initial state" do
      expect(user).to be_unverified
    end

    it "can be verified" do
      user.verify!
      expect(user).to be_verified
    end

    it "can be unverified" do
      user.verify!
      user.unverify!
      expect(user).to be_unverified
    end
  end

  describe "agree_policy_terms" do
    it { should validate_acceptance_of(:agree_policy_terms).on(:create) }
  end

  describe "email" do
    it { should validate_presence_of(:email) }

    it "generates email_validation_hash" do
      expect(FactoryBot.create(:user).email_validation_hash).to be_present
    end

    it "validates uniqueness of email " do
      # http://stackoverflow.com/questions/17635189
      FactoryBot.create(:user, email: 'john@bitsushi.com')
      expect{FactoryBot.create(:user, email: 'JOHN@bitsushi.com')}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should downcase email before creation" do
      expect(FactoryBot.create(:user, email: "UPPER@CASE.com").email).to eq("upper@case.com")
    end

    it "generates new email_validation_hash when unverified" do
      user.verify!
      hash = user.email_validation_hash
      user.unverify!
      hash2 = user.email_validation_hash
      expect(hash).to_not eq(hash2)
    end

    it "has email_string" do
      user = FactoryBot.build(:user, first_name: "Bill", last_name: "Gates", email: "bill@microsoft.com")
      expect(user.email_string).to eq('"Bill Gates" <bill@microsoft.com>')
    end

    it "has admin_emails" do
      superadmin = FactoryBot.create(:user, email: "superadmin@gmail.com")
      labadmin = FactoryBot.create(:user, email: "admin@gmail.com")
      user = FactoryBot.create(:user, email: "user@gmail.com")
      superadmin.add_role :superadmin
      labadmin.add_role :admin, FactoryBot.create(:lab)
      expect(User.admin_emails).to eq([superadmin.email])
    end

  end

  describe "username" do
    it "cannot use username with reserved name" do
      %w(api labs users).each do |u|
        expect{FactoryBot.create(:user, username: u)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    it "only allows alphanumerics in username" do
      %w(wrong-username not_allowed).each do |u|
        expect{FactoryBot.create(:user, username: u)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    it "validates uniqueness of username" do
      FactoryBot.create(:user, username: 'john')
      expect{FactoryBot.create(:user, username: 'john')}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "avatar_url" do
    it "has default avatar" do
      user = FactoryBot.build_stubbed(:user)
      expect(user.avatar_url).to include('gravatar')
      expect(user.avatar_url).to include('default-user-avatar')
    end
  end

  describe "locale" do
    it "has default locale" do
      expect(FactoryBot.build_stubbed(:user).default_locale).to eq(I18n.default_locale)
    end

    it "has custom locale" do
      expect(FactoryBot.build_stubbed(:user, locale: 'fr').default_locale).to eq('fr')
    end
  end

  it "has full_name" do
    user = FactoryBot.build_stubbed(:user, first_name: "Homer", last_name: "Simpson")
    expect(user.full_name).to eq("Homer Simpson")
    expect(user.to_s).to eq("Homer Simpson")
  end

  it "has .applied_to?" do
    expect(user.applied_to? lab).to be false
    employee = FactoryBot.create(:employee, user: user, lab: lab)
    expect(user.applied_to? lab).to be true
  end

  describe ".employed_by?" do

    it "includes approved employed users" do
      employee = FactoryBot.create(:employee, user: user, lab: lab)
      employee.approve!
      expect(user).to be_employed_by(lab)
    end

    it "doesn't include unverified employed users" do
      employee = FactoryBot.create(:employee, user: user, lab: lab)
      expect(user).to_not be_employed_by(lab)
    end

  end

  describe ".superadmin?" do
    it "is not superadmin" do
      expect(FactoryBot.build_stubbed(:user)).to_not have_role(:superadmin)
      expect(user).to_not be_superadmin
    end

    it "can be made superadmin" do
      user.add_role :superadmin
      expect(user).to be_superadmin
    end

    it "is only superadmin if global admin" do
      user.add_role :superadmin, FactoryBot.create(:lab)
      expect(user).to_not be_superadmin
    end
  end

  it "has recovery_key" do
    expect(user.recovery_key).to be_blank
    recovery1 = FactoryBot.create(:recovery, email_or_username: user.email)
    expect(user.recovery_key).to eq(recovery1.key)
    recovery2 = FactoryBot.create(:recovery, email_or_username: user.email)
    expect(user.recovery_key).to eq(recovery2.key)
  end

end
