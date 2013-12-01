  #   it "can see backstage link" do
  #     sign_in user
  #     expect(page).to_not have_link('Backstage')
  #     user.add_role :admin
  #     visit root_path
  #     expect(page).to have_link('Backstage')
  #   end