require 'spec_helper'
require 'webmock/rspec'

describe MailchimpService::Client do
    let(:api_key) { "1234-us1" }
    let(:list_id) { "some-id"}
    let(:user) { FactoryBot.create(:user)}

    before do
        @client = MailchimpService::Client.instance
        @client.setOptions(options={:api_key => api_key, :list_id => list_id} )
        @api_root = "https://us1.api.mailchimp.com/3.0"
    end

    it "allows to list members" do
        stub_request(:get, "#{@api_root}/lists/{@list_id}/members")        
        res = @client.members()
    end

    it "allows to subscribe members" do

        user_hash = Digest::MD5.hexdigest( user.email.downcase )

        req_body = { email_address: user.email, status: "subscribed", 
            merge_fields: { LNAME: user.last_name, FNAME: user.first_name}} 
        
        headers = {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Basic YXBpa2V5OjEyMzQtdXMx',
            'Content-Type'=>'application/json',
            'User-Agent'=>'Faraday v0.17.0'
             }
        stub_request(:put, "#{@api_root}/lists/#{list_id}/members/#{user_hash}").
          with(
            body: req_body.to_json , headers: headers).
          to_return(status: 200, body: "", headers: {})  
        @client.subscribe(user)
        # expect(res.status).to eq(200)
    end


    it "allows to unsubscribe members" do

        user_hash = Digest::MD5.hexdigest( user.email.downcase )
        stub_request(:patch, "https://us1.api.mailchimp.com/3.0/lists/#{list_id}/members/#{user_hash}").
          with(
            body: "{\"status\":\"unsubscribed\"}").
          to_return(status: 200, body: "", headers: {})  
        @client.unsubscribe(user)
        # expect(res.status).to eq(200)
    end

end
