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

  def self.connect_with(email, api_key)
    Rubyflare::Connect.new(email: email, api_key: api_key)
  end

  def self.connect(token: nil, api_key: nil, email: nil)
    Rubyflare::Connect.new(token: token, api_key: key, email: email)
  end
end
