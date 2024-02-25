require File.expand_path('error', __dir__)

module Tibber
  # Deals with authentication flow and stores it within global configuration
  module Authentication

    # Authorize to the Tibber portal using the access_token
    # @see https://developer.tibber.com/docs/guides/calling-api
    def login(options = {})
      raise ConfigurationError, "Accesstoken/api-key not set" unless access_token
      # only bearer token needed
      # will do sanity check if token if valid
      graphql_call('{viewer{name}}')
    rescue GraphQLError => e
      raise AuthenticationError.new e
    end

  end
end
