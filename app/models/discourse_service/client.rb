require 'net/http'
module DiscourseService
  class Client
    include Singleton

    attr_accessor :api_key, :api_username, :endpoint

    def initialize(options = {})
      @api_key = options[:api_key] || Figaro.env.discourse_api_key
      @api_username = options[:api_username] || Figaro.env.discourse_api_username
      @endpoint = options[:endpoint] || Figaro.env.discourse_endpoint
    end

    def latest_topics
      call(:get, '/latest.json')
    end

    def create_topic(parameters = {})
      call(:post, '/posts.json', parameters)
    end

    def update_topic(id, parameters = {})
      call(:put, "/t/#{id}.json", parameters.merge(topic_id: id))
    end

    def call(verb, path, parameters = {})
      response = request(verb, path, parameters)
      if response.status == 200
        JSON.parse(response.body)
      elsif response.status > 300 && response.status < 500
        raise ArgumentError, response.body
      else
        raise StandardError, response.body
      end
    end

    def request(verb, path, parameters = {})
      case verb
      when :get
        connection.get(path, parameters)
      when :post
        connection.post(path, merge_parameters(parameters).to_query)
      when :put
        connection.put(path, merge_parameters(parameters).to_query)
      else
        raise 'unkown verb'
      end
    end

    def merge_parameters(parameters = {})
      {
        api_key: @api_key,
        api_username: @api_username
      }.merge(parameters)
    end

    def connection(options = {})
      options = {
        url: @endpoint
      }
      Faraday.new(options) do |conn|
        conn.adapter :net_http
      end
    end
  end
end
