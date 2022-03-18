module Requests
  module JsonHelpers
    attr_reader :response

    def json
      JSON.parse(response.body)
    end

    def method_missing(method, *args)
      return unless method =~ /_helper$/

      raise "#{method} expects a valid argument, '#{args.first}' passed" if args.first.blank?
      raise "#{args.first.class} is not persisted" if args.first.try(:id).blank?

      method.to_s.gsub(/_helper$/, 'Serializer').classify.constantize.new(args.first, root: nil).attributes.as_json
    end
  end

  module AuthenticationHelpers
    def get_as_user(url, options = {})
      get(url, params: options, headers:  _user_auth_headers)

    end

    def get_as_admin(url, options = {})
      get(url, params: options,  headers: _admin_auth_headers)
    end

    [:post, :put, :delete, :patch].each do |m|
      define_method "#{m}_as_user" do |url, opts = {}|
        opts = {} if opts.blank?
        opts = opts.to_json unless opts.values.any? { |v| v.class == Rack::Test::UploadedFile }

        send(m, url, params: opts, headers: _user_auth_headers )
      end
    end

    [:post, :put, :delete, :patch].each do |m|
      define_method "#{m}_as_admin" do |url, opts = {}|
        opts = {} if opts.blank?
        opts = opts.to_json unless opts.values.any? { |v| v.class == Rack::Test::UploadedFile }

        send(m, url, opts, _admin_auth_headers)
      end
    end
  
    private

      def _user_auth_headers
        {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'Authorization' => "Bearer #{_access_token}",
          'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) ' \
            'Chrome/19.0.1084.56 Safari/536.5',
          'X-API-Version' => '0.0.1',
          'X-API-Client' => 'ExampleApp/TestSuite 0.0.1',
          'X-API-Device' => 'iPhone 5,1 (iOS 8.1.3)'
        }
      end

      def _admin_auth_headers
        {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json',
          'Authorization' => "Bearer #{_admin_access_token}",
          'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) ' \
            'Chrome/19.0.1084.56 Safari/536.5',
          'X-API-Version' => '0.0.1',
          'X-API-Client' => 'ExampleApp/TestSuite 0.0.1',
          'X-API-Device' => 'iPhone 5,1 (iOS 8.1.3)'
        }
      end


      def _user
        raise '"user" variable in request tests is not defined' unless respond_to?(:user) || user.present?
        user
      end

      def _admin
        raise '"admin" variable in request tests is not defined' unless respond_to?(:admin) || admin.present?
        admin.add_role :superadmin
        admin
      end
      
      def _access_token
        @_access_token ||= FactoryBot.create(:access_token, application: _client_application, resource_owner_id: _user.id, scopes: "public").token
      end

      def _admin_access_token
        @_admin_access_token ||= FactoryBot.create(:access_token, application: _client_application, resource_owner_id: _admin.id, scopes: "public").token
      end

      def _client_application
        @_client_application ||= try(:oauth_application) || FactoryBot.create(:oauth_application)
      end
     end
end
