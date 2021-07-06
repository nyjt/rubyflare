module Rubyflare
  class Connect

    attr_reader :response

    API_URL = "https://api.cloudflare.com/client/v4/"

    def initialize(**options)
      @api_token = options[:api_token]
      @email = options[:email]
      @api_key = options[:api_key]
      @custom_headers = options[:custom_headers] || {}
    end
    
    %i(get post put patch delete).each do |method_name|
      define_method(method_name) do |endpoint, options = {}|
        options = options.to_json unless method_name == :get
        response = Curl.send(method_name, API_URL + endpoint, options) do |http|
          headers = {
            'Content-Type': 'application/json',
            'User-Agent': "Rubyflare/#{Rubyflare::VERSION}"
          }
          # Send the Bearer request if using an API Token
          unless @api_token.nil?
            headers['Authorization'] = "Bearer " + @api_token
          else
            headers['X-Auth-Email'] = @email
            headers['X-Auth-Key'] = @api_key
          end
          http.headers = headers.merge(@custom_headers)
        end
        @response = Rubyflare::Response.new(method_name, endpoint, response.body_str)
      end
    end
  end
end

