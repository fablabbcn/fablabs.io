
  #   it "shows validate message for unvalidated user" do
  #     sign_in user
  #     expect(page).to have_content("validate your email address")
  #   end

  #   it "doesn't show validate message for validated user" do
  #     user.verify!
  #     sign_in user
  #     expect(page).to_not have_content("validate your email address")
  #   end

  #   it "can resend verification email" do
  #     sign_in user
  #     click_link "Resend Verification Email"
  #     expect(last_email.to).to include(user.email)
  #     expect(page).to have_content('Thanks')
  #   end