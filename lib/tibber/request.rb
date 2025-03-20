# frozen_string_literal: true

require 'faraday'

module Tibber
  # Deals with requests
  module Request
    # JSON-RPC is a stateless, light-weight remote procedure call (RPC) protocol. Primarily this
    # specification defines several data structures and the rules around their processing. It is
    # transport agnostic in that the concepts can be used within the same process, over sockets, over
    # http, or in many various message passing environments. It uses JSON (RFC 4627) as data format.
    #
    # https://www.jsonrpc.org/specification
    module GraphQL
      ##
      # Executes a GraphQL query with optional parameters.
      #
      # @param query [String] The GraphQL query string.
      # @param params [Hash, nil] (optional) Parameters to be interpolated into the query.
      # @return [WrAPI::Request::Entity] The parsed response data.
      # @raise [GraphQLError] If the response contains GraphQL errors.
      #
      # @example Basic GraphQL call
      #   query = "{ user(id: %d) { name email } }"
      #   graphql_call(query, { id: 123 })
      #
      def graphql_call(query, params = nil)
        query = (query % params) if params&.any?
        options = {
          "query": query
        }
        result = post('', options)
        raise GraphQLError.new(result.body['errors']) if result.body['errors']

        data = result.body['data']
        WrAPI::Request::Entity.create(data['viewer'] || data)
      rescue Faraday::BadRequestError => e
        body = e.response[:body]
        error = body&.dig('errors') || e.to_s
        raise GraphQLError.new(error)
      end
    end
  end
end
