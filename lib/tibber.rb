# frozen_string_literal: true

require 'wrapi'
require File.expand_path('tibber/client', __dir__)
require File.expand_path('tibber/version', __dir__)

# The `Tibber` module provides an API client for interacting with the Tibber GraphQL API.
# It extends `WrAPI::Configuration` and `WrAPI::RespondTo`, enabling configuration handling.
#
# @example Creating a client instance:
#   client = Tibber.client(api_key: "your-api-key")
#
# @example Resetting the client configuration:
#   Tibber.reset
#
module Tibber
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  # Default User-Agent string for API requests.
  DEFAULT_UA = "Ruby Tibber API client #{Tibber::VERSION}"

  # Default API endpoint for Tibber.
  DEFAULT_ENDPOINT = 'https://api.tibber.com/v1-beta/gql'

  # Creates a new instance of the Tibber API client.
  #
  # @param options [Hash] Optional configuration overrides.
  # @option options [String] :user_agent Custom user agent string.
  # @option options [String] :endpoint Custom API endpoint.
  #
  # @return [Tibber::Client] The initialized API client.
  #
  # @example Creating a client with default settings:
  #   client = Tibber.client
  #
  # @example Creating a client with a custom user agent:
  #   client = Tibber.client(user_agent: "My Custom UA")
  def self.client(options = {})
    Tibber::Client.new({ user_agent: DEFAULT_UA, endpoint: DEFAULT_ENDPOINT }.merge(options))
  end

  # Resets the Tibber module's configuration to default values.
  #
  # @example Resetting the configuration:
  #   Tibber.reset
  #
  # @return [void]
  def self.reset
    super
    self.endpoint   = nil
    self.user_agent = DEFAULT_UA
    self.endpoint   = DEFAULT_ENDPOINT
  end
end
