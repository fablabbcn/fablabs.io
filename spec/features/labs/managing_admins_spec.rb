# pending "managing admins" do
#   let(:admin) { FactoryGirl.create(:user) }
#   let(:lab) { FactoryGirl.create(:lab, creator: admin) }
#   let(:user) { FactoryGirl.create(:user) }

#   # it "can add an admin" do
#   #   lab.approve!
#   #   sign_in admin
#   #   visit lab_path(lab)
#   #   click_link "Manage Admins"
#   #   click_button "Update"
#   #   expect(page).to have_content("Admins updated")
#   # end

#   it "can apply to become admin" do
#     sign_in user
#     visit lab_path(lab)
#     click_link "Apply to become an admin"
#     fill_in "Description", with: "I work here"
#     click_button "Submit"
#     expect(page).to have_content("Application submitted")
#   end

#   it "admin doesn't need to apply to become admin" do
#     sign_in admin
#     visit lab_path(lab)
#     expect(page).to_not have_link("Apply to become an admin")
#   end

# end