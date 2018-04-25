require 'spec_helper'

describe Lab do

  let(:lab) { FactoryGirl.create(:lab) }

  it { should have_many(:academics) }
  it { should have_many(:admin_applications) }
  it { should have_many(:discussions) }
  it { should have_many(:employees) }
  it { should have_many(:links) }
  it { should have_many(:events) }
  it { should have_many(:referees).through(:referee_approval_processes)}
  it { should have_many(:role_applications) }
  it { should have_many(:facilities) }
  it { should have_many(:machines).through(:facilities) }

  it { should belong_to(:creator) }
  it { should belong_to(:referee) }

  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:country_code) }
  it { should validate_presence_of(:slug).with_message('is invalid') }
  pending { should validate_presence_of(:creator) }
  pending { should validate_presence_of(:referee) }
  pending { should validate_presence_of(:employees).on(:create) }
  it { should validate_presence_of(:address_1) }

  it "is valid" do
    expect(lab).to be_valid
  end

  it "has to_s" do
    expect(FactoryGirl.build_stubbed(:lab, name: "Magic Lab").to_s).to eq("Magic Lab")
  end

  it "validates uniqueness of name" do
    FactoryGirl.create(:lab, name: 'uniquename')
    expect{ FactoryGirl.create(:lab, name: 'Uniquename') }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "validates uniqueness of slug" do
    FactoryGirl.create(:lab, slug: 'uniqueslug')
    expect{ FactoryGirl.create(:lab, slug: 'Uniqueslug') }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "only allows alphanumerics in slug" do
    ['no-SLUG', 'sm', 'N*tthis', 'no no no'].each do |slug|
      expect{FactoryGirl.create(:lab, slug: slug)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "has Kinds" do
    expect(Lab::Kinds).to eq(%w(mini_fab_lab fab_lab supernode mobile))
  end

  it "has Capabilities" do
    expect(Lab::Capabilities).to eq(%w(three_d_printing cnc_milling circuit_production laser precision_milling vinyl_cutting))
  end

  it "has capabilities bitmask" do
    lab = FactoryGirl.create(:lab, capabilities: [:cnc_milling, :laser])
    expect(lab.capabilities?(:cnc_milling, :laser)).to be_true
  end

  it "has search_for" do
    berlin = FactoryGirl.create(:lab, name: "Berlin Fab Lab")
    FactoryGirl.create(:lab, name: "Fab Lab Barcelona")
    expect(Lab.search_for("Berlin")).to eq([berlin])
  end

  it "has ancestry" do
    dad = FactoryGirl.create(:comment)
    child = FactoryGirl.create(:comment, parent: dad)
    expect(dad.children).to include(child)
  end

  it "truncates blurb before save" do
    expect(FactoryGirl.create(:lab, blurb: ("a"*255)).blurb).to eq("a"*250)
  end

  describe "slug" do
    pending "validates uniqueness of slug"

    pending "auto creates slug" do
      expect(FactoryGirl.build(:lab, name: "Fab Lab Disney").slug).to eq('fablabdisney')
    end

    it "cannot use slug with reserved name" do
      %w(labs users).each do |word|
        expect{FactoryGirl.create(:lab, slug: word)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "states" do

    it "is unverified" do
      expect(FactoryGirl.build(:lab)).to be_unverified
    end

    it "can be removed" do
      superadmin = FactoryGirl.create(:user)
      superadmin.add_role :superadmin
      lab.approve(superadmin)
      lab.remove(superadmin)
      expect(lab).to be_removed
      expect(Lab.with_removed_state).to include(lab)
      expect(Lab.with_approved_state).to_not include(lab)
    end

    it "can be approved" do
      superadmin = FactoryGirl.create(:user)
      superadmin.add_role :superadmin
      lab.approve(superadmin)
      expect(lab).to be_approved
      expect(Lab.with_approved_state).to include(lab)
    end

    it "can be rejected" do
      superadmin = FactoryGirl.create(:user)
      superadmin.add_role :superadmin
      lab.reject(superadmin)
      expect(lab).to be_rejected
      expect(Lab.with_rejected_state).to include(lab)
      expect(Lab.with_approved_state).to_not include(lab)
    end

    it "adds employees and makes creator admin when approved" do
      superadmin = FactoryGirl.create(:user)
      superadmin.add_role :superadmin
      expect(lab.creator).to_not have_role(:admin, lab)
      lab.approve(superadmin)
      expect(lab.creator).to have_role(:admin, lab)
      expect(lab.creator).to_not have_role(:admin)
      expect(lab.employees).to eq(lab.employees.with_approved_state)
    end
  end

  describe "email" do
    it "downcases email before creation" do
      expect(FactoryGirl.create(:lab, email: "UPPER@CASE.com").email).to eq("upper@case.com")
    end

    it "disallows invalid email" do
      ['invalid', 'not an email'].each do |email|
        expect{FactoryGirl.create(:lab, email: email)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "kind" do
    it "is active if not planned" do
      lab = FactoryGirl.create(:lab, kind: 0)
      expect(lab).to_not be_active
      lab.kind = 1
      expect(lab).to be_active
    end
  end

  describe "address" do

    pending "get_time_zone" do
      it "calls get_time_zone" do
        lab.latitude = 10
        lab.save
        expect(lab).to receive(:get_time_zone)
      end
    end

    pending "reverse geocode"

    it "should have geocomplete" do
      expect(lab).to respond_to(:geocomplete)
    end

    it "has .short_address" do
      lab = FactoryGirl.build_stubbed(:lab, city: 'London', country_code: 'gb')
      expect(lab.short_address).to eq("London, County, #{lab.country}")
    end

    it "has .formatted_address" do
      lab = FactoryGirl.build_stubbed(:lab, address_1: 'a house', city: 'paris', country_code: 'gb')
      expect(lab.formatted_address).to eq("a house, paris, County, #{lab.country}")
    end

    it "has .in_country_code scope" do
      gb = FactoryGirl.create(:lab, country_code: 'gb')
      fr = FactoryGirl.create(:lab, country_code: 'fr')
      expect(Lab.in_country_code('gb')).to eq([gb])
    end

    describe "country" do
      it "has .country" do
        I18n.locale = 'en'
        expect(FactoryGirl.build_stubbed(:lab, country_code: 'es').country.to_s).to eq('Spain')
        I18n.locale = I18n.default_locale
      end

      it "has .country_list_for labs" do
        FactoryGirl.create(:lab, country_code: 'eg')
        FactoryGirl.create(:lab, country_code: 'fr')
        FactoryGirl.create(:lab, country_code: 'fr')
        I18n.locale = 'en'
        expect(Lab.country_list_for Lab.all).to eq([['Egypt', 'eg', 1], ['France', 'fr', 2]])
        I18n.locale = 'de'
        expect(Lab.country_list_for Lab.all).to eq([['Ägypten', 'eg', 1], ['Frankreich', 'fr', 2]])
        I18n.locale = I18n.default_locale
      end

      it "has localised country method" do
        pending 'i18n stuff'
        # lab = FactoryGirl.build_stubbed(:lab, country_code: 'FR')
        # I18n.locale = 'en'
        # expect(lab.country.name).to eq('France')
        # I18n.locale = 'es'
        # expect(lab.country.name).to eq('Francia')
        # I18n.locale = I18n.default_locale
      end
    end
  end

  describe "has nearby_labs" do
    before(:each) do
      @manchester = FactoryGirl.create(:lab, city: 'manchester', latitude: 53.479465, longitude: -2.252591, country_code: 'gb')
      liverpool = FactoryGirl.create(:lab, city: 'liverpool', latitude: 53.409532, longitude: -2.983575, country_code: 'gb')
      london = FactoryGirl.create(:lab, city: 'london', latitude: 51.498485, longitude: -0.116158, country_code: 'gb')
      amsterdam = FactoryGirl.create(:lab, city: 'amsterdam', latitude: 52.382306, longitude: 4.821396, country_code: 'nl')

      Lab.update_all("workflow_state = 'approved'")
    end

    it "has nearby in same country" do
      expect(@manchester.nearby_labs(true, 100).map(&:city)).to eq(['liverpool'])
      expect(@manchester.nearby_labs(true, 1000).map(&:city)).to eq(['liverpool', 'london'])
    end

    it "has nearby in all countries" do
      expect(@manchester.nearby_labs(false, 100).map(&:city)).to eq(['liverpool'])
      expect(@manchester.nearby_labs(false, 1000).map(&:city)).to eq(['liverpool', 'london', 'amsterdam'])
    end

    pending "approved state"
  end

  describe "admins" do
    before(:each) do
      @superadmin = FactoryGirl.create(:user)
      @user = FactoryGirl.create(:user)
      @superadmin.add_role :superadmin
    end

    it "has needs_admin?" do
      lab = FactoryGirl.create(:lab, workflow_state: :approved)
      User.with_role(:admin, lab).delete_all
      expect(lab.needs_admin?).to be_true
      expect(@superadmin).to have_role(:superadmin)
      @user.add_role :admin, lab
      expect(lab.needs_admin?).to be_false
    end

    it "has .admins" do
      admin = FactoryGirl.create(:user)
      admin.add_role :admin, lab
      expect(lab.admins).to eq([admin])
    end

    it "defaults to superadmins if no lab admins" do
      expect(lab.admins).to eq([@superadmin])
    end

    pending "admin_ids don't include superadmins" do
      admin = FactoryGirl.create(:user)
      expect(lab.admin_ids).to_not include(@superadmin.id)
      admin.add_role :admin, lab
      expect(lab.admin_ids).to eq([admin.id])
    end

    it "has .save_roles" do
      # check called
      expect(lab.admin_ids).to be_empty
      admin = FactoryGirl.create(:user)
      lab.admin_ids = [admin.id, @user.id]
      # expect(lab).to receive(:save_roles)
      lab.save
      expect(admin).to have_role(:admin, lab)
      lab.admin_ids = [@user.id]
      # expect(lab).to receive(:save_roles)
      lab.save
      expect(admin).to_not have_role(:admin, lab)
    end

  end

  it "has many machines/facilities" do
    lab = FactoryGirl.create(:lab)
    machine = FactoryGirl.create(:machine)
    lab.machines << machine
    expect(lab.machines).to include(machine)
    expect(lab.facilities).to include(machine.facilities.first)
    expect(machine.labs).to include(lab)
  end
end
