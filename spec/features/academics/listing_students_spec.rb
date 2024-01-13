require 'spec_helper'

feature "Showing students" do

  given(:lab) { FactoryBot.create(:lab, workflow_state: 'approved') }
  given(:user) { FactoryBot.create(:user, first_name: "Homer", last_name: "Simpson", workflow_state: "verified") }
  given(:academic) { FactoryBot.create(:academic, user: user, lab: lab) }

  scenario "as visitor" do
    academic.approver = user
    visit lab_url(lab)
    expect(page).not_to have_content("Fab Academy Students")
  end

  scenario "as a academy user" do
    admin = FactoryBot.create(:user)
    admin.add_role :superadmin
    admin.add_role :academy
    admin.verify!
    sign_in admin

    academic.approver = admin
    visit lab_url(lab)

    expect(page).to have_content("Fab Academy Students")
    expect(page).to have_content("Academy Website")
  end

end
