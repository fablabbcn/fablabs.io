require 'gibbon'

module MailchimpService
    class Client
        include Singleton
  
        attr_accessor :api_key, :list_id
        
        def initialize(options = {})
            @api_key = options[:api_key] || Figaro.env.mailchimp_api_key
            @list_id = options[:list_id] || Figaro.env.mailchimp_list_id
            Rails.logger.info("MailchimpService::Client.initialize: #{@api_key}, #{list_id}")
            @gibbon = Gibbon::Request.new(api_key: api_key, debug: true)
        end

        def setOptions(options = {})
            @api_key = options[:api_key] || Figaro.env.mailchimp_api_key
            @list_id = options[:list_id] || Figaro.env.mailchimp_list_id
            Rails.logger.info("MailchimpService::Client.setOptions: #{@api_key}, #{list_id}")
            @gibbon = Gibbon::Request.new(api_key: api_key, debug: true)
        end

        def subscribe(user)
            if @list_id.nil?
                raise "list_id can't be null"
           end
           begin
                @lowercase_email_hash = Digest::MD5.hexdigest(user.email.downcase)
                res = @gibbon.lists(@list_id).members(@lowercase_email_hash).upsert(body: {
                    email_address: user.email,
                    status: "subscribed",
                    merge_fields: {LNAME: user.last_name, FNAME: user.first_name}
                })
                return res
            rescue => e
                logger.error "MailchimpService::Client Failed to subscribe user: #{e.message} - #{e.raw_body}"
            end
            return nil
        end


        def members()
            if @list_id.nil?
                raise "list_id can't be null"
           end
           begin
                return @gibbon.lists(@list_id).members()
            rescue => e
                logger.error "MailchimpService::Client Failed to list members: #{e.message} - #{e.raw_body}"
            end
            return nil
        end

        def unsubscribe(user)
            if @list_id.nil?
                raise "list_id can't be null"
           end
           begin
                @lowercase_email_hash = Digest::MD5.hexdigest(user.email.downcase)
                res = @gibbon.lists(@list_id).members(@lowercase_email_hash).update(body: {
                    status: "unsubscribed",
                })
                return res
            rescue => e
                logger.error "MailchimpService::Client Failed to unsubscribe user: #{e.message} - #{e.raw_body}"
            end
            return nil
        end
    end
end
    