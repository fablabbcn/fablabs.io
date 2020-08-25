if ENV['MAILCHIMP_ENABLED'] == true
    @mailchimp_client = MailchimpService::Client.instance
    @mailchimp_client.setOptions(api_key: ENV['MAILCHIMP_API_KEY'], lab_id: ENV['MAILCHIMP_LAB_ID'])
end
