if Figaro.env.mailchimp_enabled == true
    @mailchimp_client = MailchimpService::Client.instance
    @mailchimp_client.setOptions(api_key: Figaro.env.mailchimp_api_key, lab_id: Figaro.env.mailchimp_lab_id)
end