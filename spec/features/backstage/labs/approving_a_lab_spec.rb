require 'spec_helper'
require 'pry'

feature "Approving a lab" do

  given!(:lab_admin) { FactoryBot.create(:user) }
  let!(:referee) { FactoryBot.create(:lab, workflow_state: :approved, creator: lab_admin) }
  let!(:referee_employee) { FactoryBot.create(:employee, user: lab_admin, lab: referee) }

  given!(:lab_admin_as220) { FactoryBot.create(:user) }
  given!(:lab_admin_bcn) { FactoryBot.create(:user) }
  given!(:lab_admin_cascina) { FactoryBot.create(:user) }

  let!(:as220) { FactoryBot.create(:lab, name: "AS220 Labs", slug: "as220labs", workflow_state: :approved, creator: lab_admin_as220) }
  let!(:bcn) { FactoryBot.create(:lab, name: "Fab Lab BCN", slug: "fablabbcn", workflow_state: :approved, creator: lab_admin_bcn) }
  let!(:cascina) { FactoryBot.create(:lab, name: "Fab Lab Cascina", slug: "fablabcascina", workflow_state: :approved, creator: lab_admin_cascina) }

  let!(:lab) { FactoryBot.create(:lab, referee: referee) }
  let!(:new_lab) { FactoryBot.create(:lab, referee: referee) }

  background do
    lab_admin.verify!
    lab_admin_as220.verify!
    lab_admin_bcn.verify!
    lab_admin_cascina.verify!
    lab_admin_as220.add_role :admin, as220
    lab_admin_bcn.add_role :admin, bcn
    lab_admin_cascina.add_role :admin, cascina
  end

  scenario "as an admin" do
    lab = FactoryBot.create(:lab, referee: referee)
    sign_in_superadmin
    visit backstage_lab_path(lab)
    click_button "Approve"
    expect(page).to have_content("Lab approved")
  end

  scenario "approve lab with new process as an admin" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    sign_in_superadmin
    visit backstage_lab_path(new_lab)
    click_button "Approve"
    expect(page).to have_content("Lab approved")
  end

  scenario "referees approve-reject-approve lab" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    new_lab.referee_approval_processes.create(referee_lab: as220)
    new_lab.referee_approval_processes.create(referee_lab: bcn)
    new_lab.referee_approval_processes.create(referee_lab: cascina)

    sign_in lab_admin_bcn
    expect(lab_admin_bcn.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee approves"
    expect(page).to have_content("Lab referee approved")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("referee_approval")
    sign_out lab_admin_bcn

    sign_in lab_admin_as220
    expect(lab_admin_as220.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee rejects"
    expect(page).to have_content("Lab referee rejected")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("undecided")
    sign_out lab_admin_as220

    sign_in lab_admin_cascina
    expect(lab_admin_cascina.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee approves"
    expect(page).to have_content("Lab referee approved")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("approved")
  end

  scenario "referees reject-reject lab" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    new_lab.referee_approval_processes.create(referee_lab: as220)
    new_lab.referee_approval_processes.create(referee_lab: bcn)
    new_lab.referee_approval_processes.create(referee_lab: cascina)

    sign_in lab_admin_bcn
    expect(lab_admin_bcn.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee rejects"
    expect(page).to have_content("Lab referee rejected")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("might_need_review")
    sign_out lab_admin_bcn

    sign_in lab_admin_as220
    expect(lab_admin_as220.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee rejects"
    expect(page).to have_content("Lab referee rejected")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("rejected")
    sign_out lab_admin_as220
  end

  scenario "referees approve-approve lab" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    new_lab.referee_approval_processes.create(referee_lab: as220)
    new_lab.referee_approval_processes.create(referee_lab: bcn)
    new_lab.referee_approval_processes.create(referee_lab: cascina)

    sign_in lab_admin_bcn
    expect(lab_admin_bcn.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee approves"
    expect(page).to have_content("Lab referee approved")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("referee_approval")
    sign_out lab_admin_bcn

    sign_in lab_admin_as220
    expect(lab_admin_as220.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee approves"
    expect(page).to have_content("Lab referee approved")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("approved")
    sign_out lab_admin_as220
  end

  scenario "referees edit form to request more info" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    new_lab.referee_approval_processes.create(referee_lab: as220)
    new_lab.referee_approval_processes.create(referee_lab: bcn)
    new_lab.referee_approval_processes.create(referee_lab: cascina)

    sign_in lab_admin_bcn
    expect(lab_admin_bcn.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Request more info"
    expect(page).to have_content("Improve approval application")
  end

  scenario "referees requests more info" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    new_lab.referee_approval_processes.create(referee_lab: as220)
    new_lab.referee_approval_processes.create(referee_lab: bcn)
    new_lab.referee_approval_processes.create(referee_lab: cascina)

    sign_in lab_admin_bcn
    expect(lab_admin_bcn.is_referee?).to eq(true)
    visit request_more_info_backstage_lab_path(new_lab)
    click_button "Save"
    expect(page).to have_content("Lab requested more info")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("need_more_info")
  end

  scenario "referees requests admin approval" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    new_lab.referee_approval_processes.create(referee_lab: as220)
    new_lab.referee_approval_processes.create(referee_lab: bcn)
    new_lab.referee_approval_processes.create(referee_lab: cascina)

    sign_in lab_admin_bcn
    expect(lab_admin_bcn.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee requests admin approval"
    expect(page).to have_content("Lab referee requested admin approval")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("admin_approval")
  end

  scenario "referees approves-requests-more-info-approves approval" do
    new_lab = FactoryBot.create(:lab, referee: referee)
    new_lab.referee_approval_processes.create(referee_lab: as220)
    new_lab.referee_approval_processes.create(referee_lab: bcn)
    new_lab.referee_approval_processes.create(referee_lab: cascina)

    sign_in lab_admin_as220
    expect(lab_admin_as220.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Referee approves"
    expect(page).to have_content("Lab referee approved")
    updated_lab = Lab.find(new_lab.id)
    expect(updated_lab.workflow_state).to eq("referee_approval")
    sign_out lab_admin_as220

    sign_in lab_admin_bcn

    expect(lab_admin_bcn.is_referee?).to eq(true)
    visit backstage_lab_path(new_lab)
    click_button "Request more info"
    expect(page).to have_content("Improve approval application")

    updated_lab.update_attributes(workflow_state: :more_info_added)
    updated_lab.employees.update_all(workflow_state: :more_info_added)
    updated_lab.more_info_added
    new_updated_lab = Lab.find(updated_lab.id)

    visit backstage_lab_path(new_updated_lab)
    click_button "Referee approves"
    expect(page).to have_content("Lab referee approved")
    newest_updated_lab = Lab.find(new_updated_lab.id)
    expect(newest_updated_lab.workflow_state).to eq("approved")
  end

end
