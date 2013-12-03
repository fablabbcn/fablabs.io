# require 'spec_helper'

# describe Machine do

#   let(:machine) { FactoryGirl.create(:machine, name: 'Shopbot') }

#   # describe :unauthenticated do
#   #   it "has no index" do
#   #     visit machines_path
#   #     expect(page.status_code).to eq(403)
#   #   end

#   # end

#   describe :user do
#     before(:each) do
#       @user = FactoryGirl.create(:user)
#       @user.verify!
#       sign_in @user
#     end

#     it "has no index" do
#       visit machines_path
#       expect(page.status_code).to eq(403)
#     end

#     it "cannot create machine" do
#       visit machines_path
#       expect(page).to_not have_link("Add lab")
#       visit new_machine_path
#       expect(page.status_code).to eq(403)
#     end

#     it "cannot edit machine" do
#       visit machine_path(machine)
#       expect(page).to_not have_link("Edit Machine")
#       visit edit_machine_path(machine)
#       expect(page.status_code).to eq(403)
#     end

#   end

#   describe :admin do
#     before(:each) do
#       @admin = FactoryGirl.create(:user)
#       @admin.add_role :admin
#       sign_in @admin
#     end

#     # it "has index" do
#     #   machine.reload
#     #   visit machines_path
#     #   expect(page).to have_title('Machines')
#     #   expect(page).to have_link('Shopbot')
#     # end

#     # it "has show page" do
#     #   visit machine_path(machine)
#     #   expect(page).to have_title(machine.name)
#     #   expect(page).to have_css('h1', text: machine.name)
#     # end

#     # it "can create machine" do
#     #   visit machines_path
#     #   click_link "New Machine"
#     #   fill_in "Name", with: "Replicator 2"
#     #   fill_in "Description", with: "3D Printer"
#     #   click_button "Create Machine"
#     #   expect(page).to have_css("h1", text: "Replicator 2")
#     # end

#     # it "can edit machine" do
#     #   visit machine_path(machine)
#     #   click_link "Edit"
#     #   fill_in "Name", with: "SHOP BOT"
#     #   click_button "Update Machine"
#     #   expect(page).to have_css("h1", text: "SHOP BOT")
#     # end

#   end

# end
