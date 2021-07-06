require 'rubyflare/version'
require 'rubyflare/connect'
require 'rubyflare/response'

require 'curb'
require 'json'

module Rubyflare
  class ConnectionError < StandardError
    attr_reader :response
    def initialize(message, response)
      super(message)
      @response = response
    end
  end

  def self.connect_with(email, api_key, custom_headers={})
    Rubyflare::Connect.new(email: email, api_key: api_key, custom_headers: custom_headers)
  end

  def self.connect_with_token(api_token, custom_headers={})
    Rubyflare::Connect.new(api_token: api_token, custom_headers: custom_headers)
  end
end
