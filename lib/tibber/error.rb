# frozen_string_literal: true

module Tibber
  # Generic error to be able to rescue all Hudu errors
  class TibberError < StandardError; end

  # GraphQL returns error
  class GraphQLError < TibberError; end

  # GraphQL returns error
  class ConfigurationError < TibberError; end

  # Issue authenticting
  class AuthenticationError < TibberError; end
end
