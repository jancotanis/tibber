require "wrapi"
require File.expand_path('tibber/client', __dir__)
require File.expand_path('tibber/version', __dir__)

module Tibber
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  DEFAULT_UA = "Ruby Tibber API client #{Tibber::VERSION}".freeze
  DEFAULT_ENDPOINT = 'https://api.tibber.com/v1-beta/gql'.freeze
  #
  # @return [Hudu::Client]
  def self.client(options = {})
    Tibber::Client.new({ user_agent: DEFAULT_UA, endpoint: DEFAULT_ENDPOINT }.merge(options))
  end

  def self.reset
    super
    self.endpoint   = nil
    self.user_agent = DEFAULT_UA
    self.endpoint   = DEFAULT_ENDPOINT
  end
end
