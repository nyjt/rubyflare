module Rubyflare
  class Connect

    attr_reader :response

    API_URL = "https://api.cloudflare.com/client/v4/"

    def initialize(token: nil, api_key: nil, email: nil)
      @email = email
      @api_key = api_key
      @token = token
    end

    %i(get post put patch delete).each do |method_name|
      define_method(method_name) do |endpoint, options = {}|
        options = options.to_json unless method_name == :get
        auth_headers = {}
        if @token
          auth_headers['Authorization'] = "Bearer #{@token}"
        elsif @api_key
          if @email
            auth_headers['X-Auth-Key'] = @api_key
            auth_headers['X-Auth-Email'] = @email
          else
            auth_headers['X-Auth-User-Service-Key'] = @api_key
          end
        end

        response = Curl.send(method_name, API_URL + endpoint, options) do |http|
          http.headers = auth_headers
          http.headers['Content-Type'] = 'application/json'
          http.headers['User-Agent'] = "Rubyflare/#{Rubyflare::VERSION}"
        end
        @response = Rubyflare::Response.new(method_name, endpoint, response.body_str)
      end
    end
  end
end


