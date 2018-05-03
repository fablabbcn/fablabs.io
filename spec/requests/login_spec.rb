require 'rails_helper'

RSpec.describe "Login process", type: :request do
  describe "GET /signin" do
    it "Shows login page" do
      get signin_path
      expect(response).to have_http_status(200)
    end
  end
end
